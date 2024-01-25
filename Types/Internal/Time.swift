import Foundation

struct Time {
    
    // arrival time at the specific stop on the route
    let estimateTime: Date
    
    // bools that set bus behavior, we'll have to test these to see how accurate they are
    let isArriving, isDeparted: Bool

}

typealias Times = [Time]
