//
//  RefreshButton.swift
//  Bustle
//
//  Created by Carter Brehm on 2/1/24.
//

import SwiftUI

struct RefreshButton: View {
    @EnvironmentObject var fetcher: Fetcher
    var body: some View {
        Button {
            Task {
                try await fetcher.fetch(mock: false)
            }
        } label: {
            if fetcher.isFetching {
                ProgressView().progressViewStyle(.circular)
            } else {
                Image(systemName: "arrow.counterclockwise")
            }
        }
    }
}
