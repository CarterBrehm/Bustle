//
//  RoutesList.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct RouteList: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        List(viewModel.getRoutes()) { route in
            NavigationLink(value: route) {
                RouteRow(routeId: route.id, viewModel: viewModel)
            }.listRowSeparator(.hidden)
        }
        .navigationTitle("Routes")
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            RefreshButton(viewModel: viewModel)
        }
        .navigationDestination(for: Route.self, destination: { route in
            RouteDetailView(route: route, viewModel: viewModel)
        })
    }
}
