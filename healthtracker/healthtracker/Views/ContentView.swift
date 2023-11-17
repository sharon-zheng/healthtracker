//
//  ContentView.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthData: HealthData
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HealthDataView()
                .tabItem {
                    Label("Health Data", systemImage: "square.grid.2x2.fill")
                }.tag(0).environmentObject(healthData)
            
            HistoryView(selectedTab: $selectedTab)
                .tabItem {
                    Label("History", systemImage: "list.bullet.clipboard")
                }.tag(1).environmentObject(healthData)
            
            // goals and body stats?
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HealthData())
    }
}
