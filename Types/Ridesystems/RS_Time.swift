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

typealias RS_Times = [RS_Time]
