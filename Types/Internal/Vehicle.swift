import MapKit

struct Vehicle : Identifiable {
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
}

typealias Vehicles = [Vehicle]
