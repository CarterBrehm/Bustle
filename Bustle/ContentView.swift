//
//  ContentView.swift
//  Bustle
//
//  Created by Carter Brehm on 8/18/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // stores all web data for the view
    @StateObject var viewModel = ViewModel()
    
    // map doodads
    @State var mapCameraPosition = Constants.origin
    var mapCameraBounds = MapCameraBounds(centerCoordinateBounds: Constants.origin.region!)
    @State var selectedMapFeature: MapFeature?
    
    // controlling UI elements
    @State var presentSheet = true
    @State var sheetDetent = PresentationDetent.medium
    
    var body: some View {
        TopMapView(mapCameraPosition: $mapCameraPosition, mapCameraBounds: mapCameraBounds, selectedMapFeature: $selectedMapFeature, busses: viewModel.getVehicles(), stops: viewModel.getStops(), routes: viewModel.getRoutes())
        .sheet(isPresented: $presentSheet) {
            NavigationStack {
                List(viewModel.getRoutes()) { route in
                    NavigationLink(destination: List(route.stops) { stop in
                        StopRow(routeColor: route.color).environment(stop).listRowSeparator(.hidden)
                    }.navigationTitle("Stops").listStyle(.plain).navigationBarTitleDisplayMode(.inline).toolbar() {
                        Button {
                            Task {
                                await viewModel.fetch()
                            }
                        } label: {
                            if viewModel.isRefreshing {
                                ProgressView().progressViewStyle(.circular)
                            } else {
                                Image(systemName: "arrow.counterclockwise")
                            }
                        }
                    }) {
                        RouteRow().environment(route)
                    }.listRowSeparator(.hidden)
                }.navigationTitle("Routes").listStyle(.plain).navigationBarTitleDisplayMode(.inline).toolbar() {
                    Button {
                        Task {
                            await viewModel.fetch()
                        }
                    } label: {
                        if viewModel.isRefreshing {
                            ProgressView().progressViewStyle(.circular)
                        } else {
                            Image(systemName: "arrow.counterclockwise")
                        }
                    }
                }
            }
            .presentationDetents([.fraction(0.07), .medium, .large], selection: $sheetDetent)
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled)

        }

    }
}


#Preview {
    ContentView()
}
