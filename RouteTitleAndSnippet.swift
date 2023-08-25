//
//  RouteTitleAndSnippet.swift
//  Bustle
//
//  Created by Carter Brehm on 8/24/23.
//

import SwiftUI

struct RouteTitleAndSnippet: View {
    var route: Route
    var vehicles: Vehicles
    var schedules: Schedules
    var body: some View {
        VStack(alignment: .leading) {
            Text(route.description).font(.title).minimumScaleFactor(0.2).lineLimit(1)
            ForEach(vehicles, id: \.vehicleID) { vehicle in
                HStack {
                    Image(systemName: "bus")
                    Text(vehicle.name.components(separatedBy: " ").last ?? "0")
                    Text("(\(vehicle.vehicleID))")
                    Text(schedules.filter{$0.times.first?.vehicleID == vehicle.vehicleID}.first?.stopDescription ?? "help")
                }
            }
        }
    }
}
