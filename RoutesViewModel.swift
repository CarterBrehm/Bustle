//
//  RouteViewModel.swift
//  Bustle
//
//  Created by Carter Brehm on 8/18/23.
//

import Foundation
import SwiftUI

@MainActor
class RoutesViewModel: ObservableObject {
    private let client = Client()
    @Published private(set) var routes: Routes = []
    @Published private(set) var uniqueStops: [Stop] = []
    @Published private(set) var stopsByAddress: [Int: Stop] = [:]
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false

        var request: URLRequest = {
            let urlString = "\(Constants.baseUrl)GetRoutesForMapWithScheduleWithEncodedLine"
            let url = URL(string: urlString)!
            return URLRequest(url: url)
        }()

        func fetch() async {
            do {
                let response = try await client.fetch(type: Routes.self, with: request)
                routes = response.compactMap { $0 }
                uniqueStops = routes.flatMap{$0.stops}.uniqued()
            } catch {
                errorMessage = "\((error as! ApiError).customDescription)"
                hasError = true
            }
        }
    
    }
