//
//  ViewModel.swift
//  Bustle
//
//  Created by Carter Brehm on 8/25/23.
//

import Foundation
import CoreLocation
import Polyline

@MainActor
class ViewModel: ObservableObject {
    
    private let client = Client()
    
    var rs_busses: [RS_Vehicle] = []
    var rs_routes: [RS_Route] = []
    var rs_schedules: [RS_Schedule] = []
    
    var timer: Timer?
    
    
    @Published private(set) var routes: [Route] = []
    @Published private(set) var vehicles: [Vehicle] = []
    @Published private(set) var orphanVehicles: [Vehicle] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isRefreshing: Bool = false
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            Task {
                await self.fetch()
            }
        })
    }
    
    init() {
        Task {
            await self.fetch()
        }
    }
    deinit {
        timer?.invalidate()
    }
    
    var rs_busses_request: URLRequest = {
        let urlString = "\(Constants.baseUrl)GetMapVehiclePoints.json"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    var rs_routes_request: URLRequest = {
        let urlString = "\(Constants.baseUrl)GetRoutesForMapWithScheduleWithEncodedLine.json"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    var rs_schedules_request: URLRequest = {
        let urlString = "\(Constants.baseUrl)GetStopArrivalTimes.json"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    func fetch() async {
        timer?.invalidate()
        isRefreshing = true
        do {
            let vehicleResponse = try await client.fetch(type: [RS_Vehicle].self, with: rs_busses_request)
            rs_busses = vehicleResponse.compactMap { $0 }
            
            let routeResponse = try await client.fetch(type: [RS_Route].self, with: rs_routes_request)
            rs_routes = routeResponse.compactMap { $0 }
            
            let scheduleResponse = try await client.fetch(type: [RS_Schedule].self, with: rs_schedules_request)
            rs_schedules = scheduleResponse.compactMap { $0 }
        } catch {
            errorMessage = "\((error as! ApiError).customDescription)"
            hasError = true
        }
        
        for rs_bus in rs_busses {
            if let route = rs_routes.first(where: { $0.routeID == rs_bus.routeID }) {
                let vehicle = Vehicle(
                    groundSpeed: rs_bus.groundSpeed,
                    heading: rs_bus.heading,
                    isOnRoute: rs_bus.isOnRoute,
                    isDelayed: rs_bus.isDelayed,
                    location: CLLocationCoordinate2D(
                        latitude: rs_bus.latitude,
                        longitude: rs_bus.longitude
                    ),
                    name: rs_bus.name,
                    id: rs_bus.vehicleID,
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
                                times: rs_schedules.filter({
                                    $0.routeID == route.routeID && $0.routeStopID == stop.routeStopID
                                }).compactMap({
                                    for rs_time in $0.times {
                                        if rs_time.vehicleID == rs_bus.vehicleID {
                                            return Time(estimateTime: Date(timeIntervalSince1970: Double(rs_time.estimateTime.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!/1000), isArriving: rs_time.isArriving, isDeparted: rs_time.isDeparted)
                                        }
                                    }
                                    return nil
                                })
                            )
                        }
                    )
                )
                vehicles.append(vehicle)
            }
        }
        isRefreshing = false
        startTimer()
    }
    
//    func getStops() -> [Stop] {
//        return Array(Set(self.getRoutes().flatMap{$0.stops}))
//    }
//
//    func getActiveRoutes() -> [Route] {
//        return routes.filter{$0.enabled && $0.vehiclesOnRoute.count > 0}.sorted{$0.vehiclesOnRoute.count > $1.vehiclesOnRoute.count}
//    }
//
//    func getRoutes() -> [Route] {
//        return routes.filter{$0.enabled}.sorted{$0.vehiclesOnRoute.count > $1.vehiclesOnRoute.count}
//    }
}
