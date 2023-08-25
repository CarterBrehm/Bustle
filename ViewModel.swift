//
//  ViewModel.swift
//  Bustle
//
//  Created by Carter Brehm on 8/25/23.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    
    private let client = Client()
    
    var rs_busses: [RS_Vehicle] = []
    var rs_routes: [RS_Route] = []
    var rs_schedules: [RS_Schedule] = []
    
    @Published private(set) var routes: [Route] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    var rs_busses_request: URLRequest = {
        let urlString = "\(Constants.baseUrl)GetMapVehiclePoints"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    var rs_routes_request: URLRequest = {
        let urlString = "\(Constants.baseUrl)GetRoutesForMapWithScheduleWithEncodedLine"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    var rs_schedules_request: URLRequest = {
        let urlString = "\(Constants.baseUrl)GetStopArrivalTimes"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    func fetch() async {
        do {
            let vehicleResponse = try await client.fetch(type: [RS_Vehicle].self, with: rs_busses_request)
            rs_busses = vehicleResponse.compactMap { $0 }
            
            let routeResponse = try await client.fetch(type: [RS_Route].self, with: rs_routes_request)
            rs_routes = routeResponse.compactMap { $0 }
            
            let scheduleResponse = try await client.fetch(type: [RS_Schedule].self, with: rs_schedules_request)
            rs_schedules = scheduleResponse.compactMap { $0 }
        } catch {
            errorMessage = "\((error as! ApiError).customDescription)"
            hasError = true
        }
        
        routes = []
        for rs_route in rs_routes {
            routes.append(Route(route: rs_route, busses: rs_busses, schedules: rs_schedules))
        }
    }
    
    func getVehicles() -> [Vehicle] {
        return Array(Set(self.routes.flatMap{$0.stops}.flatMap{$0.times}.compactMap{$0.vehicle}))
    }
    
    func getStops() -> [Stop] {
        return Array(Set(self.routes.flatMap{$0.stops}))
    }
    
    func getRoutes() -> [Route] {
        return routes.sorted{$0.vehiclesOnRoute.count > $1.vehiclesOnRoute.count}
    }
}
