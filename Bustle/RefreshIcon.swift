//
//  RefreshButton.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct RefreshIcon: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        if viewModel.isRefreshing {
            ProgressView().progressViewStyle(.circular)
        } else {
            Image(systemName: "arrow.counterclockwise")
        }
    }
}
