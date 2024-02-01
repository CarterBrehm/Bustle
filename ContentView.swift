//
//  ContentView.swift
//  Bustle
//
//  Created by Carter Brehm on 1/24/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var position = Constants.origin
    
    @State var presentSheet = true
    @State var sheetDetent = PresentationDetent.fraction(0.4)
    
    var body: some View {
        BusMap(position: $position)
        .sheet(isPresented: $presentSheet) {
            NavigationStack {
                VehicleList()
            }
            .presentationDetents([.fraction(0.07), .fraction(0.4), .large], selection: $sheetDetent)
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled)
        }
    }
}

#Preview {
    ContentView()
}
