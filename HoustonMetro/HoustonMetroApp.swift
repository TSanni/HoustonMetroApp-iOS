//
//  HoustonMetroApp.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/8/23.
//

import SwiftUI

@main
struct HoustonMetroApp: App {
    @StateObject var networkMonitor = NetworkManager()
    @StateObject var metroInfo = MetroInfoViewModel()

    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .preferredColorScheme(.dark)
                    .environmentObject(metroInfo)
                    .environmentObject(networkMonitor)
            }
            .navigationViewStyle(.stack)
        }
    }
}
