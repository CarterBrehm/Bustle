//
//  RouteRow.swift
//  Bustle
//
//  Created by Carter Brehm on 8/19/23.
//

import SwiftUI

struct RouteRow: View {
    var route: Route
    @State var showStops = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                BusCountIcon(vehicleCount: route.vehiclesOnRoute.count, routeColor: route.color)
                Text(route.name).font(.title).minimumScaleFactor(0.2).lineLimit(1)
                Spacer()
                if (showStops) {
                    Image(systemName: "chevron.down")
                } else {
                    Image(systemName: "chevron.right")
                }
            }
            if (showStops) {
//                ForEach(schedules, id: \.routeStopID) { schedule in
//                    let stop = route.stops.first{$0.routeStopID == schedule.routeStopID}!
//                    StopRow(stop: stop, schedule: schedulesViewModel.getSchedule(routeID: route.routeID, stopID: stop.addressID, vehicleID: vehicles.first!.vehicleID)!, routeColor: hexStringToColor(hex: route.mapLineColor))
//                }
                Text(route.polyline.mkPolyline!.description)
            }
            
        }.contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    showStops.toggle()
                }
            }
        .padding(.bottom)
    }
}
