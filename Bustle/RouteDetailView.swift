//
//  RouteDetailView.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct RouteDetailView: View {
    var route: Route
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        let stops = route.stops.sorted(by: {$0.times.first?.estimateTime ?? Date.distantFuture < $1.times.first?.estimateTime ?? Date.distantFuture})
            List(stops) { stop in
                NavigationLink(value: stop) {
                    StopRow(stopId: stop.id, viewModel: viewModel)
                }.listRowSeparator(.hidden)
            }
            .navigationTitle(Constants.routeShortName[route.name] ?? route.name)
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                RefreshButton(viewModel: viewModel)
            }
            .navigationDestination(for: Stop.self, destination: { stop in
                StopDetailView(stop: stop)
            })
    }
}

