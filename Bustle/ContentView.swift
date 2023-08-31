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
    
    @State private var isRotating = 0.0
    
    // map doodads
    @State var mapCameraPosition = Constants.origin
    var mapCameraBounds = MapCameraBounds(centerCoordinateBounds: Constants.origin.region!)
    @State var selectedMapFeature: MapFeature?
    @Namespace var mapScope
    
    // controlling UI elements
    @State var presentSheet = true
    @State var sheetDetent = PresentationDetent.medium
    
    var body: some View {
        Map(position: $mapCameraPosition, bounds: mapCameraBounds, interactionModes: .all, selection: $selectedMapFeature, scope: mapScope) {
            UserAnnotation()
            let busses = viewModel.getVehicles()
            ForEach(busses) { bus in
//                Marker(bus.name, systemImage: "bus", coordinate: bus.location)
                Annotation(bus.name, coordinate: bus.location) {
                    BusMapIcon()
                }
            }
            let stops = viewModel.getStops()
            ForEach(stops) { stop in
                Marker(stop.name, monogram: Text(Constants.stopMonogram[stop.name] ?? "??"), coordinate: stop.location)
            }
            let routes = viewModel.getRoutes()
            ForEach(routes) { route in
                if let coordinates = route.polyline.coordinates {
                    MapPolyline(coordinates: coordinates, contourStyle: .straight).stroke(route.color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, dash: [5,10]))
                }
            }
        }.mapControls {
            MapUserLocationButton(scope: mapScope)
            MapCompass(scope: mapScope)
            MapPitchToggle(scope: mapScope)
            MapScaleView(scope:mapScope)
        }
        .mapStyle(MapStyle.standard(elevation: .realistic, pointsOfInterest: .excludingAll))
        .sheet(isPresented: $presentSheet) {
            NavigationStack {
                VStack {
                    List(viewModel.getRoutes()) { route in
                        NavigationLink(destination: Text(route.name)) {
                            RouteRow(route: route).environment(route)
                        }.listRowSeparator(.hidden)
                    }
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
//                    Button {
//                                            
//                    } label: {
//                        Image(systemName: "gear")
//                    }
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
