import Foundation
import SwiftUI
import Polyline
import CoreLocation

struct Route : Equatable, Identifiable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var vehiclesOnRoute: [Vehicle] {
        return Array(Set(self.stops.flatMap{$0.times}.compactMap{$0.vehicle}))
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    // eg. "Durango Route" or "Scheduled ADA"
    let name: String
    
    // color of the route, used to color stops, busses, etc. converted from provided hex value
    let color: Color
    
    // sourced from ETATypeId, true if 1, otherwise false
    let enabled: Bool
    
    // decoded from encodedPolyline string
    let polyline: Polyline
    
    // different from enabled in that it doesn't hide it from the frontend
    let isRunning: Bool
    
    // primary key of route array!
    let id: Int
    
    // stops on the route
    let stops: [Stop]
    
    // pass everything in and get our fancy new route structure
    init(route: RS_Route, busses: RS_Vehicles, schedules: RS_Schedules) {
        self.name = route.description
        self.color = hexStringToColor(hex: route.mapLineColor)
        self.enabled = route.etaTypeID == 1
        self.polyline = Polyline.init(encodedPolyline: route.encodedPolyline)
        self.isRunning = route.isRunning
        self.id = route.routeID
        self.stops = route.stops.compactMap {
            let stopID = $0.addressID
            if let schedule = schedules.first(where: {$0.routeID == route.routeID && $0.stopID == stopID}) {
                return Stop(id: stopID,
                            name: $0.description,
                            location: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude),
                            order: $0.order,
                            times: schedule.times.compactMap {
                                let vehicleID = $0.vehicleID
                                let vehicle = busses.first{$0.routeID == route.routeID && $0.vehicleID == vehicleID}!
                                return Time(estimateTime: Date(timeIntervalSince1970: Double($0.estimateTime.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!/1000),
                                            isArriving: $0.isArriving,
                                            isDeparted: $0.isDeparted,
                                            vehicle: Vehicle(groundSpeed: vehicle.groundSpeed, heading: vehicle.heading, isOnRoute: vehicle.isOnRoute, isDelayed: vehicle.isDelayed, location: CLLocationCoordinate2D(latitude: vehicle.latitude, longitude: vehicle.longitude), name: vehicle.name, id: vehicle.vehicleID)
                                )
                            }
                    )
            } else {
                return Stop(id: stopID,
                            name: $0.description,
                            location: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude),
                            order: $0.order,
                            times: [Time]()
                    )
            }
        }
    }
}

struct Stop : Hashable, Equatable, Identifiable {
    
    func findNextArrival(arrivingInNextSeconds: Int = Int.max) -> Time? {
        return times.sorted(by: {$0.estimateTime < $1.estimateTime}).first(where: {Int($0.estimateTime.timeIntervalSinceNow) < arrivingInNextSeconds})
    }
    
    init(id: Int, name: String, location: CLLocationCoordinate2D, order: Int, times: [Time]) {
        self.id = id
        self.name = name
        self.location = location
        self.order = order
        self.times = times
    }
    
    static func == (lhs: Stop, rhs: Stop) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    // primary key
    let id: Int
    
    // sourced from line1 or description
    let name: String
    
    // exact coordinate of stop
    let location: CLLocationCoordinate2D
    
    // we may need this? keeping it for now
    let order: Int
    
    // all arrival times associated with the stop
    let times: [Time]
}

struct Time : Equatable, Identifiable {
    
    init(estimateTime: Date, isArriving: Bool, isDeparted: Bool, vehicle: Vehicle) {
        self.estimateTime = estimateTime
        self.isArriving = isArriving
        self.isDeparted = isDeparted
        self.vehicle = vehicle
    }
    
    static func == (lhs: Time, rhs: Time) -> Bool {
        return lhs.vehicle == rhs.vehicle
    }
    
    
    // UUID to help us keep track of everything in the UI
    let id = UUID()
    
    // arrival time at the specific stop on the route
    let estimateTime: Date
    
    // bools that set bus behavior, we'll have to test these to see how accurate they are
    let isArriving, isDeparted: Bool
    
    // the vehicle that will be arriving
    let vehicle: Vehicle
}

class Vehicle : Hashable, Equatable, Identifiable {
    
    init(groundSpeed: Double, heading: Int, isOnRoute: Bool, isDelayed: Bool, location: CLLocationCoordinate2D, name: String, id: Int) {
        self.groundSpeed = groundSpeed
        self.heading = heading
        self.isOnRoute = isOnRoute
        self.isDelayed = isDelayed
        self.location = location
        self.name = name
        self.id = id
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    // could be used to animate the vehicle between refreshes?
    let groundSpeed: Double
    let heading: Int
    
    // more bools that set bus behavior, again, needs testing
    let isOnRoute, isDelayed: Bool
    
    // exact coordinate of bus
    let location: CLLocationCoordinate2D
    
    // name of bus "Bus 472"
    let name: String
    
    // primary key of bus
    let id: Int
}

func hexStringToColor (hex:String) -> Color {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return Color.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return Color(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0
    )
}

// MARK: - Vehicle
struct RS_Vehicle: Codable {
    let heading: Int
    let isDelayed, isOnRoute: Bool
    let latitude, longitude, groundSpeed: Double
    let name: String
    let routeID: Int
    let vehicleID: Int

    enum CodingKeys: String, CodingKey {
        case groundSpeed = "GroundSpeed"
        case heading = "Heading"
        case isDelayed = "IsDelayed"
        case isOnRoute = "IsOnRoute"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case name = "Name"
        case routeID = "RouteID"
        case vehicleID = "VehicleID"
    }
}

typealias RS_Vehicles = [RS_Vehicle]


// MARK: - Route
struct RS_Route: Codable {
    let description: String
    let etaTypeID: Int
    let encodedPolyline: String
    let isRunning: Bool
    let mapLineColor: String
    let order, routeID: Int
    let stops: [RS_Stop]
    let infoText: String

    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case etaTypeID = "ETATypeID"
        case encodedPolyline = "EncodedPolyline"
        case isRunning = "IsRunning"
        case mapLineColor = "MapLineColor"
        case order = "Order"
        case routeID = "RouteID"
        case stops = "Stops"
        case infoText = "InfoText"
    }
}

// MARK: - Stop
struct RS_Stop: Codable, Equatable {
    let addressID: Int
    let latitude: Double
    let longitude: Double
    let description: String
    let order: Int
    let routeID, routeStopID: Int

    enum CodingKeys: String, CodingKey {
        case addressID = "AddressID"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case description = "Description"
        case order = "Order"
        case routeID = "RouteID"
        case routeStopID = "RouteStopID"
    }
    
    public static func == (lhs: RS_Stop, rhs: RS_Stop) -> Bool {
        return lhs.addressID == rhs.addressID
    }
}

typealias RS_Routes = [RS_Route]

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

struct RS_Schedule: Codable {
    let color, routeDescription: String
    let routeID, routeStopID: Int
    let showDefaultedOnMap, showEstimatesOnMap: Bool
    let stopDescription: String
    let stopID: Int
    let times: [RS_Time]

    enum CodingKeys: String, CodingKey {
        case color = "Color"
        case routeDescription = "RouteDescription"
        case routeID = "RouteId"
        case routeStopID = "RouteStopId"
        case showDefaultedOnMap = "ShowDefaultedOnMap"
        case showEstimatesOnMap = "ShowEstimatesOnMap"
        case stopDescription = "StopDescription"
        case stopID = "StopId"
        case times = "Times"
    }
}

// MARK: - Time
struct RS_Time: Codable {
    let estimateTime: String
    let isArriving, isDeparted: Bool
    let onTimeStatus: Int
    let text: String
    let vehicleID: Int

    enum CodingKeys: String, CodingKey {
        case estimateTime = "EstimateTime"
        case isArriving = "IsArriving"
        case isDeparted = "IsDeparted"
        case onTimeStatus = "OnTimeStatus"
        case text = "Text"
        case vehicleID = "VehicleId"
    }
}

typealias RS_Schedules = [RS_Schedule]

// MARK: - Encode/decode helpers

class JSONNull: Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

