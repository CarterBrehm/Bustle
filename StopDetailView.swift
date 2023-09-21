//
//  StopDetailView.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct StopDetailView: View {
    var stop: Stop
    var body: some View {
        Text(stop.name)
    }
}

