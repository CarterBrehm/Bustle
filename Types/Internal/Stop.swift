import CoreLocation

struct Stop: Identifiable, Equatable, Hashable {
    // primary key
    let id: Int
    
    // uniquely identifies address, could be useful to show which stops are the same?
    let addressId: Int
    
    // sourced from line1 or description
    let name: String
    
    // exact coordinate of stop
    let location: CLLocationCoordinate2D
    
    // we may need this? keeping it for now
    let order: Int
    
    // times (will be filtered by bus)
    let times: [Time]
    
    // identifying same addresses
    static func ==(left: Stop, right: Stop) -> Bool {
        return left.addressId == right.addressId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(addressId)
    }
}

typealias Stops = [Stop]
