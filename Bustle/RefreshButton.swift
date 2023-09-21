//
//  RefreshButton.swift
//  Bustle
//
//  Created by Carter Brehm on 9/19/23.
//

import SwiftUI

struct RefreshButton: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Button {
            Task {
                await viewModel.fetch()
            }
        } label: {
            RefreshIcon(viewModel: viewModel)
        }
    }
}
