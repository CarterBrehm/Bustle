//
//  RoutePreviewText.swift
//  Bustle
//
//  Created by Carter Brehm on 8/29/23.
//

import SwiftUI

struct StopPreviewText: View {
    @StateObject var stop: Stop
    var body: some View {
        if let time = stop.times.first {
            let formatter: RelativeDateTimeFormatter = RelativeDateTimeFormatter()
            let timeDescription: String = time.isArriving ? "arriving" : formatter.localizedString(for: time.estimateTime, relativeTo: Date.now)
            let timeString: String = " (" + timeDescription + ")"
            let bus: String = "🚌"
            let arrow: String = " → "
            let vehicleNumber: String = time.vehicle.name.components(separatedBy: " ").last ?? "999"
            let stopMonogram: String = Constants.stopMonogram[stop.name] ?? "XX"
            let text: String = bus + vehicleNumber + arrow + stopMonogram + timeString
            Text(text)
        }
    }
}
