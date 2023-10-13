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
    @ObservedObject var viewModel = ViewModel()
    
    // map doodads
    @State var mapCameraPosition = Constants.origin
    var mapCameraBounds = MapCameraBounds(centerCoordinateBounds: Constants.origin.region!)
    @State var selectedMapFeature: MapFeature?
    let locationManager = CLLocationManager()
    
    // controlling UI elements
    @State var presentSheet = true
    @State var sheetDetent = PresentationDetent.fraction(0.4)
    @State private var detentHeight: CGFloat = .zero

    
    var body: some View {
//        TopMapView(mapCameraPosition: $mapCameraPosition, mapCameraBounds: mapCameraBounds, selectedMapFeature: $selectedMapFeature, busses: viewModel.getVehicles(), stops: viewModel.getStops(), routes: viewModel.getActiveRoutes())
//            .onAppear {
//                locationManager.requestWhenInUseAuthorization()
//            }
//        .sheet(isPresented: $presentSheet) {
//            NavigationStack {
//                RouteList(viewModel: viewModel)
//            }
//            .presentationDetents([.fraction(0.07), .fraction(0.4), .large], selection: $sheetDetent)
//            .interactiveDismissDisabled()
//            .presentationBackgroundInteraction(.enabled)
//
//        }
    }
}


#Preview {
    ContentView()
}

