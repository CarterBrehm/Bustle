struct RS_Stop: Codable {
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
}

typealias RS_Stops = [RS_Stop]
