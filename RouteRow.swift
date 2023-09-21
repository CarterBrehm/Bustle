//
//  RouteRow.swift
//  Bustle
//
//  Created by Carter Brehm on 8/19/23.
//

import SwiftUI

struct RouteRow: View {
    @Binding var route: Route
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    let routeName = Constants.routeShortName[route.name] ?? route.name
                    Text(routeName).font(.title).minimumScaleFactor(0.2).lineLimit(1).bold(route.isRunning && route.vehiclesOnRoute.count > 0)
//                    let timeLimit: Double = 300
//                    let stops = route.stops.filter{$0.times.first?.estimateTime.timeIntervalSinceNow ?? Double.infinity < timeLimit}.sorted{$0.times.first?.estimateTime.timeIntervalSinceNow ?? Double.infinity < $1.times.first?.estimateTime.timeIntervalSinceNow ?? Double.infinity}
                }
                Spacer()
                BusCountIcon(vehicleCount: route.vehiclesOnRoute.count, routeColor: route.color)
            }
        }.contentShape(Rectangle())
    }
}
