//
//  ScheduledStopDescription.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct ScheduledStopDescription: View {
    var time: Time
    var stopMonogram: String
    var body: some View {
        let bus: String = "🚌"
        let arrow: String = " → "
        let vehicleNumber: String = time.vehicle.name.components(separatedBy: " ").last ?? "999"
        let stoppedAsOf = " (as of "
        let rhombus = Image(systemName: "octagon.fill")
        let ago = " ago)"
        let parIn = " (in "
        let parOut = ")"
        if (time.isArriving) {
            Text(bus + vehicleNumber + " ") + Text(rhombus) + Text(" " + stopMonogram + stoppedAsOf) + Text(time.estimateTime, style: .relative) + Text(ago)
        } else {
            Text(bus + vehicleNumber) + Text(arrow + stopMonogram + parIn) + Text(time.estimateTime, style: .relative) + Text(parOut)
        }
    }
}
