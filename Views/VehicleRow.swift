//
//  VehicleRow.swift
//  Bustle
//
//  Created by Carter Brehm on 1/25/24.
//

import SwiftUI

struct VehicleRow: View {
    @Binding var vehicle: Vehicle
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(Image(systemName: "bus")).font(.system(size: 48)).multilineTextAlignment(.trailing).foregroundStyle(vehicle.route?.color ?? Color.gray).overlay(alignment: .center, content:  {
                    Text(vehicle.number).font(.system(size: 16)).monospaced().foregroundStyle(.white).bold().offset(y: -8)
                })
            }
            VStack(alignment: .leading) {
                Text(vehicle.name).font(.title).minimumScaleFactor(0.2).lineLimit(1).bold()
                Text("some grey text below the bus").font(.caption)
            }
            Spacer()
        }
    }
}
