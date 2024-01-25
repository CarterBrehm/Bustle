//
//  ContentView.swift
//  Bustle
//
//  Created by Carter Brehm on 1/24/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.2436841, longitude: -96.0106684), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)))
    
    var body: some View {
        BusMap(position: $position)
    }
}

#Preview {
    ContentView()
}
