//
//  SchedulesViewModel.swift
//  Bustle
//
//  Created by Carter Brehm on 8/18/23.
//

import Foundation

@MainActor
class SchedulesViewModel: ObservableObject {
    private let client = Client()
    @Published private(set) var schedules: Schedules = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false

        var request: URLRequest = {
            let urlString = "\(Constants.baseUrl)GetStopArrivalTimes"
            let url = URL(string: urlString)!
            return URLRequest(url: url)
        }()

        func fetch() async {
            do {
                let response = try await client.fetch(type: Schedules.self, with: request)
                schedules = response.compactMap { $0 }
            } catch {
                errorMessage = "\((error as! ApiError).customDescription)"
                hasError = true
            }
        }
    
    func getSchedule(routeID: Int, stopID: Int, vehicleID: Int) -> Schedule? {
        if let fullSchedule = schedules.filter({$0.routeID == routeID}).filter({$0.stopID == stopID}).first {
            if let specificTime = fullSchedule.times.filter({$0.vehicleID == vehicleID}).first {
                var specificTimeSchedule = Schedule(color: fullSchedule.color, routeDescription: fullSchedule.routeDescription, routeID: fullSchedule.routeID, routeStopID: fullSchedule.routeStopID, showDefaultedOnMap: fullSchedule.showDefaultedOnMap, showEstimatesOnMap: fullSchedule.showEstimatesOnMap, stopDescription: fullSchedule.stopDescription, stopID: fullSchedule.stopID, times: [specificTime])
                return fullSchedule
            }
        }
        return nil
    }
}
