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

typealias RS_Routes = [RS_Route]
