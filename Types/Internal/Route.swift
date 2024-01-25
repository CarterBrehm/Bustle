import SwiftUI
import Polyline

struct Route: Identifiable {
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
}

typealias Routes = [Route]
