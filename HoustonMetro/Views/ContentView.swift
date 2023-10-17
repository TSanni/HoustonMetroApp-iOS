//
//  ContentView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/8/23.
//

import SwiftUI
import Combine



struct ContentView: View {
    @StateObject var metroInfo = MetroInfoViewModel()
    
    var body: some View {
        
        List {
            
            /// Route picker
            Section("Routes") {
                Picker("Route", selection: $metroInfo.routeSelection) {
                    ForEach(metroInfo.routes.value) { item in
                        Text(item.RouteName)
                            .tag(item.RouteName)
                    }
                }
            }
        
            /// Stop picker
            Section("Stops") {
                Picker("Stops", selection: $metroInfo.stopSelection) {
                    ForEach(metroInfo.stopsForRoute.value) { item in
                        Text(item.Name)
                            .tag(item.Name)
                    }
                }
            }
        }
        .padding()
    }
    
    
    

    
    
    

}

#Preview {
    NavigationView {
        ContentView()
    }
}
