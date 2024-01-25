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

typealias RS_Schedules = [RS_Schedule]
