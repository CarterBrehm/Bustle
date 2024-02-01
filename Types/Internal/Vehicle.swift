import MapKit

struct Vehicle : Identifiable, Hashable, Equatable {
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
    
    // route that this bus is currently traveling on (could be none, for ADA bus)
    let route: Route?
    
    var number: String {
        return self.name.components(separatedBy: " ").last ?? "999"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func ==(left: Vehicle, right: Vehicle) -> Bool {
        return left.id == right.id
    }
}

typealias Vehicles = [Vehicle]
