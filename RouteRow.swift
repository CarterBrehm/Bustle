//
//  RouteRow.swift
//  Bustle
//
//  Created by Carter Brehm on 8/19/23.
//

import SwiftUI

struct RouteRow: View {
    @StateObject var route: Route
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    let routeName = Constants.routeShortName[route.name] ?? route.name
                    Text(routeName).font(.title).minimumScaleFactor(0.2).lineLimit(1).bold()
                    let timeLimit: Double = 300
                    let stops = route.stops.filter{$0.times.first?.estimateTime.timeIntervalSinceNow ?? Double.infinity < timeLimit}.sorted{$0.times.first?.estimateTime.timeIntervalSinceNow ?? Double.infinity < $1.times.first?.estimateTime.timeIntervalSinceNow ?? Double.infinity}
                    ForEach(stops) { stop in
                        if let time = stop.times.first {
                            if (time.isArriving) {
                                let timeDescription: String = "arriving"
                                let timeString: String = " (" + timeDescription + ")"
                                let bus: String = "🚌"
                                let arrow: String = " → "
                                let vehicleNumber: String = time.vehicle.name.components(separatedBy: " ").last ?? "999"
                                let stopMonogram: String = Constants.stopMonogram[stop.name] ?? "XX"
                                let text: String = bus + vehicleNumber + arrow + stopMonogram + timeString
                                Text(text)
                            } else {
                                let formatter: RelativeDateTimeFormatter = RelativeDateTimeFormatter()
                                let timeDescription: String = formatter.localizedString(for: time.estimateTime, relativeTo: Date.now)
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
                }
                Spacer()
                BusCountIcon(vehicleCount: route.vehiclesOnRoute.count, routeColor: route.color)
            }
        }.contentShape(Rectangle())
    }
}
