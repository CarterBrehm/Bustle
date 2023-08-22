// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let routes = try? JSONDecoder().decode(Routes.self, from: jsonData)

import Foundation

// MARK: - Route
struct Route: Codable {
    let description: String
    let etaTypeID: Int
    let encodedPolyline, gtfsID: String
    let hideRouteLine: Bool
    let infoText: String
    let isCheckLineOnlyOnMap, isCheckedOnMap, isRunning, isVisibleOnMap: Bool
    let landmarks: [JSONAny]
    let mapLatitude: Double
    let mapLineColor: String
    let mapLongitude: Double
    let mapZoom, order, routeID: Int
    let routeVehicleIcon: String
    let showPolygon, showRouteArrows: Bool
    let stopTimesPDFLink: String
    let stops: [Stop]
    let textingKey: String
    let useScheduleTripsInPassengerCounter: Bool
    let vehicleMarkerCSSClass: String

    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case etaTypeID = "ETATypeID"
        case encodedPolyline = "EncodedPolyline"
        case gtfsID = "GtfsId"
        case hideRouteLine = "HideRouteLine"
        case infoText = "InfoText"
        case isCheckLineOnlyOnMap = "IsCheckLineOnlyOnMap"
        case isCheckedOnMap = "IsCheckedOnMap"
        case isRunning = "IsRunning"
        case isVisibleOnMap = "IsVisibleOnMap"
        case landmarks = "Landmarks"
        case mapLatitude = "MapLatitude"
        case mapLineColor = "MapLineColor"
        case mapLongitude = "MapLongitude"
        case mapZoom = "MapZoom"
        case order = "Order"
        case routeID = "RouteID"
        case routeVehicleIcon = "RouteVehicleIcon"
        case showPolygon = "ShowPolygon"
        case showRouteArrows = "ShowRouteArrows"
        case stopTimesPDFLink = "StopTimesPDFLink"
        case stops = "Stops"
        case textingKey = "TextingKey"
        case useScheduleTripsInPassengerCounter = "UseScheduleTripsInPassengerCounter"
        case vehicleMarkerCSSClass = "VehicleMarkerCssClass"
    }
}

// MARK: - Stop
struct Stop: Codable {
    let addressID: Int
    let city: String
    let latitude: Double
    let line1, line2: String
    let longitude: Double
    let state, zip, description, gtfsID: String
    let heading: Int
    let mapPoints: [JSONAny]
    let maxZoomLevel, order: Int
    let routeDescription: String
    let routeID, routeStopID, secondsAtStop, secondsToNextStop: Int
    let showDefaultedOnMap, showEstimatesOnMap: Bool
    let signVerbiage, textingKey: String

    enum CodingKeys: String, CodingKey {
        case addressID = "AddressID"
        case city = "City"
        case latitude = "Latitude"
        case line1 = "Line1"
        case line2 = "Line2"
        case longitude = "Longitude"
        case state = "State"
        case zip = "Zip"
        case description = "Description"
        case gtfsID = "GtfsId"
        case heading = "Heading"
        case mapPoints = "MapPoints"
        case maxZoomLevel = "MaxZoomLevel"
        case order = "Order"
        case routeDescription = "RouteDescription"
        case routeID = "RouteID"
        case routeStopID = "RouteStopID"
        case secondsAtStop = "SecondsAtStop"
        case secondsToNextStop = "SecondsToNextStop"
        case showDefaultedOnMap = "ShowDefaultedOnMap"
        case showEstimatesOnMap = "ShowEstimatesOnMap"
        case signVerbiage = "SignVerbiage"
        case textingKey = "TextingKey"
    }
}

typealias Routes = [Route]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
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

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
