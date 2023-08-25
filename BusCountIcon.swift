//
//  BusCountIcon.swift
//  Bustle
//
//  Created by Carter Brehm on 8/24/23.
//

import SwiftUI

struct BusCountIcon: View {
    var vehicleCount: Int
    var routeColor: Color
    var body: some View {
        HStack {
            let busIconSystemName = vehicleCount > 1 ? "bus.doubledecker" : "bus"
            (Text((String(vehicleCount))) + Text(Image(systemName: busIconSystemName))).font(.largeTitle.monospaced()).multilineTextAlignment(.trailing).foregroundStyle(routeColor).bold(vehicleCount > 0)
        }
    }
}

#Preview {
    BusCountIcon(vehicleCount: 2, routeColor: .red)
}
