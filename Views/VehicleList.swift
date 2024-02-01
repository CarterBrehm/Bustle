//
//  VehicleList.swift
//  Bustle
//
//  Created by Carter Brehm on 1/25/24.
//

import SwiftUI

struct VehicleList: View {
    @EnvironmentObject var fetcher: Fetcher
    var body: some View {
        List($fetcher.vehicles) { $vehicle in
            NavigationLink(value: vehicle) {
                VehicleRow(vehicle: $vehicle).listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            ToolbarItem(placement: .topBarLeading) {
                VStack() {
                    Spacer().frame(height: 8)
                    Text("Bustle").font(.largeTitle).bold()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                RefreshButton()
            }
        }
        .navigationDestination(for: Vehicle.self, destination: { vehicle in
            Text(vehicle.name)
        })
    }
}

#Preview {
    VehicleList()
}
