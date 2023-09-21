//
//  RouteRow.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct RouteRow: View {
    var routeId: Int
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        if let route = viewModel.getRoutes().first(where: {$0.id == routeId}){
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        let routeName = Constants.routeShortName[route.name] ?? route.name
                        Text(routeName).font(.title).minimumScaleFactor(0.2).lineLimit(1).bold(route.isRunning && route.vehiclesOnRoute.count > 0)
                        let stops = route.stops
                        ForEach(stops) { stop in
                            if let time = stop.findNextArrival(arrivingInNextSeconds: 180) {
                                ScheduledStopDescription(time: time, stopMonogram: Constants.stopMonogram[stop.name] ?? stop.name)
                            }
                        }
                        
                    }
                    Spacer()
                    BusCountIcon(vehicleCount: route.vehiclesOnRoute.count, routeColor: route.color)
                }
            }.contentShape(Rectangle())
        }
    }
}
