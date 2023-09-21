//
//  StopRow.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct StopRow: View {
    var stopId: Int
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        if let stop = viewModel.getStops().first(where: {$0.id == stopId}) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(stop.name).font(.title).minimumScaleFactor(0.2).lineLimit(1)
                        if let time = stop.findNextArrival(arrivingInNextSeconds: 600) {
                            ScheduledStopDescription(time: time, stopMonogram: Constants.stopMonogram[stop.name] ?? stop.name)
                        } else {
                            Text("No busses within the next 20 minutes.")
                        }
                    }
                    Spacer()
                }
            }.contentShape(Rectangle())
        }
    }
}
