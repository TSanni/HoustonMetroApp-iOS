//
//  ContentView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/8/23.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var metroInfo: MetroInfoViewModel
    @EnvironmentObject var networkMonitor: NetworkManager
    var body: some View {
        
        if networkMonitor.isConnected {
            HomeView()
                .onAppear { metroInfo.getAllRoutes() }
        } else {
            NoInternetView()
        }
        
        
    }
    
    
}

#Preview {
    NavigationView {
        ContentView()
            .environmentObject(MetroInfoViewModel())
            .environmentObject(NetworkManager())
    }
}
