import Foundation
import Polyline
import CoreLocation

@MainActor
class Fetcher: ObservableObject {
    // holding our returned data
    @Published var vehicles = Vehicles()
    
    // client for fetching
    private let client = Client()
    
    // timer for autorefresh
    @Published var timer: Timer?
    
    // broadcast when we are refreshing
    @Published var isFetching = false
    
    let urlBase = "https://unomaha.ridesystems.net/Services/JSONPRelay.svc/"
    
    let vehicleEndpoint = "GetMapVehiclePoints"
    let routeEndpoint = "GetRoutesForMapWithScheduleWithEncodedLine"
    let scheduleEndpoint = "GetStopArrivalTimes"
    
    init(mock: Bool) {
        Task {
            try await self.fetch(mock: mock)
        }
    }
    
    func fetch(mock: Bool) async throws {
        
        isFetching = true
        
        // fetch stops and times
        let scheduleRequest = mock ? URLRequest(url: Bundle.main.url(forResource: "GetStopArrivalTimes", withExtension: "json")!) : URLRequest(url: URL(string: urlBase + scheduleEndpoint)!)
        let scheduleResponse = try await client.fetch(type: RS_Schedules.self, with: scheduleRequest)
        
        // fetch routes
        let routeRequest = mock ? URLRequest(url: Bundle.main.url(forResource: "GetRoutesForMapWithScheduleWithEncodedLine", withExtension: "json")!) : URLRequest(url: URL(string: urlBase + routeEndpoint)!)
        let routeResponse = try await client.fetch(type: RS_Routes.self, with: routeRequest)
        
        // fetch vehicles
        let vehicleRequest = mock ? URLRequest(url: Bundle.main.url(forResource: "GetMapVehiclePoints", withExtension: "json")!) : URLRequest(url: URL(string: urlBase + vehicleEndpoint)!)
        let vehicleResponse = try await client.fetch(type: RS_Vehicles.self, with: vehicleRequest)
        
        vehicles = vehicleResponse.compactMap({ rs_vehicle in
            if let route = routeResponse.first(where: { $0.routeID == rs_vehicle.routeID }) {
                let vehicle = Vehicle(
                    groundSpeed: rs_vehicle.groundSpeed,
                    heading: rs_vehicle.heading,
                    isOnRoute: rs_vehicle.isOnRoute,
                    isDelayed: rs_vehicle.isDelayed,
                    location: CLLocationCoordinate2D(
                        latitude: rs_vehicle.latitude,
                        longitude: rs_vehicle.longitude
                    ),
                    name: rs_vehicle.name,
                    id: rs_vehicle.vehicleID,
                    route: Route(
                        name: route.description,
                        color: hexStringToColor(hex: route.mapLineColor),
                        enabled: route.etaTypeID == 1,
                        polyline: Polyline.init(encodedPolyline: route.encodedPolyline),
                        isRunning: route.isRunning,
                        id: route.routeID,
                        stops: route.stops.compactMap { stop in
                            return Stop(
                                id: stop.routeStopID,
                                addressId: stop.addressID,
                                name: stop.description,
                                location: CLLocationCoordinate2D(
                                    latitude: stop.latitude,
                                    longitude: stop.longitude
                                ),
                                order: stop.order,
                                times: scheduleResponse.filter({
                                    $0.routeID == route.routeID && $0.routeStopID == stop.routeStopID
                                }).compactMap({
                                    for rs_time in $0.times {
                                        if rs_time.vehicleID == rs_vehicle.vehicleID {
                                            return Time(estimateTime: Date(timeIntervalSince1970: Double(rs_time.estimateTime.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!/1000), isArriving: rs_time.isArriving, isDeparted: rs_time.isDeparted)
                                        }
                                    }
                                    return nil
                                })
                            )
                        }
                    )
                )
                return vehicle
            }
            return nil
        })
        isFetching = false
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
            Task {
                try await self.fetch(mock: mock)
            }
        })
    }
}
