//
//  healthtrackerApp.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI

@main
struct healthtrackerApp: App {
    @StateObject var healthData: HealthData = HealthData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(healthData)
        }
    }
}
