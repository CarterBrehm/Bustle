//
//  BustleApp.swift
//  Bustle
//
//  Created by Carter Brehm on 1/24/24.
//

import SwiftUI

@main
struct BustleApp: App {
    @StateObject private var fetcher = Fetcher(mock: true)
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(fetcher)
        }
    }
}
