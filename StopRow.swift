//
//  StopRow.swift
//  Bustle
//
//  Created by Carter Brehm on 8/19/23.
//

import SwiftUI

struct StopRow: View {
    @EnvironmentObject var stop: Stop
    var routeColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(stop.name).font(.title).minimumScaleFactor(0.2).lineLimit(1)
                    StopPreviewText().environment(stop)
                }
                Spacer()
                Image(systemName: "octagon.fill").font(.largeTitle).foregroundColor(routeColor).frame(width: 75.0, height: nil, alignment: .center)
            }
        }.contentShape(Rectangle())
    }
}
