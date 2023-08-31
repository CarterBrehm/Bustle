//
//  StopRow.swift
//  Bustle
//
//  Created by Carter Brehm on 8/19/23.
//

import SwiftUI

struct StopRow: View {
    var stop: Stop
    var routeColor: Color
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "octagon.fill").font(.largeTitle).foregroundColor(routeColor).frame(width: 75.0, height: nil, alignment: .center)
                VStack(alignment: .leading) {
                    Text(stop.name).font(.title).minimumScaleFactor(0.2).lineLimit(1)
                    let formatter = RelativeDateTimeFormatter()
                    ForEach(stop.times, id: \.vehicle) { time in
                        Text("🚌" + time.vehicle.name.components(separatedBy: " ").last! + "→" + formatter.localizedString(for: time.estimateTime, relativeTo: Date.now))
                    }
//                    if let time = stop.times.first {
//                        Text(time.vehicle.name + " " + formatter.localizedString(for: time.estimateTime, relativeTo: Date.now))
//                    }
                }
                Spacer()
            }
        }
    }
}
