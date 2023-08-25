//
//  BusRow.swift
//  Bustle
//
//  Created by Carter Brehm on 8/22/23.
//

import SwiftUI

struct BusRow: View {
    var vehicle: Vehicle
    var body: some View {
        Text(vehicle.name)
    }
}

#Preview {
BusRow(vehicle: Vehicle(heading: 0, isDelayed: false, isOnRoute: true, latitude: 0, longitude: 0, groundSpeed: 0, name: "Bus 999", routeID: 0, vehicleID: 0))
}
