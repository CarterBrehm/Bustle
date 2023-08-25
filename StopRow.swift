//
//  StopRow.swift
//  Bustle
//
//  Created by Carter Brehm on 8/19/23.
//

import SwiftUI

struct StopRow: View {
    var stop: Stop
    var schedule: Schedule
    var routeColor: Color
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "octagon.fill").font(.title2).multilineTextAlignment(.trailing)
                VStack(alignment: .leading) {
                    Text(stop.description).font(.title2)
                    Text(schedule.times.first!.vehicleID.description)
                }
                Spacer()
            }
        }
    }
}
