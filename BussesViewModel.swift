//
//  RouteViewModel.swift
//  Bustle
//
//  Created by Carter Brehm on 8/18/23.
//

import Foundation

@MainActor
class BussesViewModel: ObservableObject {
    private let client = Client()
    @Published private(set) var busses: Vehicles = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false

        var request: URLRequest = {
            let urlString = "\(Constants.baseUrl)GetMapVehiclePoints"
            let url = URL(string: urlString)!
            return URLRequest(url: url)
        }()

        func fetch() async {
            do {
                let response = try await client.fetch(type: Vehicles.self, with: request)
                busses = response.compactMap { $0 }
            } catch {
                errorMessage = "\((error as! ApiError).customDescription)"
                hasError = true
            }
        }
    
    func getBussesWithRouteID(id: Int) -> Vehicles {
        return busses.filter{$0.routeID == id}
    }

}
