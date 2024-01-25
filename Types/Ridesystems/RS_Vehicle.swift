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
