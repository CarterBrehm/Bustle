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
    @Namespace var mapScope
    
    // controlling UI elements
    @State var isRefreshing = false;
    @State var presentSheet = true
    @State var sheetDetent = PresentationDetent.medium
    
    var body: some View {
        Map(position: $mapCameraPosition, bounds: mapCameraBounds, interactionModes: .all, selection: $selectedMapFeature, scope: mapScope) {
            let busses = viewModel.getVehicles()
            ForEach(busses, id: \.vehicleID) { bus in
                Marker(bus.name, systemImage: "bus", coordinate: bus.location)
            }
            let stops = viewModel.getStops()
            ForEach(stops, id: \.stopID) { stop in
                Marker(stop.name, monogram: Text(Constants.stopMetadata[stop.name] ?? "??"), coordinate: stop.location)
            }
            let routes = viewModel.getRoutes()
            ForEach(routes, id: \.routeID) { route in
                MapPolyline(coordinates: route.polyline.coordinates!, contourStyle: .straight).stroke(route.color, lineWidth: 5).strokeStyle(style: StrokeStyle(lineWidth: 5, lineCap: .butt, lineJoin: .round))
            }
        }.task {
            isRefreshing = true
            await viewModel.fetch()
            debugPrint(viewModel.routes)
            isRefreshing = false
        }
        .mapControls{
            MapUserLocationButton(scope: mapScope).padding(.all)
        }
        .mapStyle(MapStyle.standard(elevation: .realistic, pointsOfInterest: .excludingAll))
        .sheet(isPresented: $presentSheet) {
            VStack{
                HStack(alignment: .firstTextBaseline) {
                    Text("Bustle").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading).padding([.leading, .top, .trailing])
                    Button {
                        Task {
                            isRefreshing = true
                            await viewModel.fetch()
                            isRefreshing = false
                        }
                    } label: {
                        if isRefreshing {
                            Image(systemName: "clock.arrow.circlepath").padding([ .trailing]).font(.title3)
                        } else {
                            Image(systemName: "arrow.counterclockwise").padding([ .trailing]).font(.title3)
                        }
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "gear").padding([ .trailing]).font(.title3)
                    }
                }
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.getRoutes(), id: \.routeID) { route in
                            RouteRow(route: route).padding([.trailing, .leading])
                        }
                    }
                }
            }.padding(.bottom)
            .presentationDetents([.fraction(0.09), .medium, .large], selection: $sheetDetent)
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled)

        }

    }
}

#Preview {
    ContentView()
}
