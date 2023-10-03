//
//  ViewModel.swift
//  Bustle
//
//  Created by Carter Brehm on 8/25/23.
//

import Foundation
import CoreLocation

@MainActor
class ViewModel: ObservableObject {
    
    private let client = Client()
    
    var rs_busses: [RS_Vehicle] = []
    var rs_routes: [RS_Route] = []
    var rs_schedules: [RS_Schedule] = []
    
    var timer: Timer?
    
    
    @Published private(set) var routes: [Route] = []
    @Published private(set) var orphanVehicles: [Vehicle] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isRefreshing: Bool = false
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            Task {
                await self.fetch()
            }
        })
    }
    
    init() {
        Task {
            await self.fetch()
        }
    }
    deinit {
        timer?.invalidate()
    }
    
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
        timer?.invalidate()
        isRefreshing = true
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
        orphanVehicles = []
        for rs_route in rs_routes {
            routes.append(Route(route: rs_route, busses: rs_busses, schedules: rs_schedules))
        }
        for vehicle in rs_busses {
            if (!self.getVehicles().contains{$0.id == vehicle.vehicleID}) {
                orphanVehicles.append(Vehicle(groundSpeed: vehicle.groundSpeed, heading: vehicle.heading, isOnRoute: vehicle.isOnRoute, isDelayed: vehicle.isDelayed, location: CLLocationCoordinate2D(latitude: vehicle.latitude, longitude: vehicle.longitude), name: vehicle.name, id: vehicle.vehicleID))
            }
        }
        isRefreshing = false
        startTimer()
    }
    
    func getVehicles() -> [Vehicle] {
        return Array(Set(self.routes.flatMap{$0.stops}.flatMap{$0.times}.compactMap{$0.vehicle} + orphanVehicles))
    }
    
    func getStops() -> [Stop] {
        return Array(Set(self.getRoutes().flatMap{$0.stops}))
    }
    
    func getActiveRoutes() -> [Route] {
        return routes.filter{$0.enabled && $0.vehiclesOnRoute.count > 0}.sorted{$0.vehiclesOnRoute.count > $1.vehiclesOnRoute.count}
    }
    
    func getRoutes() -> [Route] {
        return routes.filter{$0.enabled}.sorted{$0.vehiclesOnRoute.count > $1.vehiclesOnRoute.count}
    }
}
