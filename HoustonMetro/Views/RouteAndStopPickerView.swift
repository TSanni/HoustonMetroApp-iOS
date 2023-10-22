//
//  RouteAndStopPickerView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/11/23.
//

import SwiftUI

struct RouteAndStopPickerView: View {
    @EnvironmentObject var metroInfo: MetroInfoViewModel
    var body: some View {
        
        List {
            
            /// Route picker
            Section("Routes") {
                Picker("Route", selection: $metroInfo.routeSelectionPicker) {
                    ForEach(metroInfo.routes.value) { item in
                        Text(item.fullName)
                            .tag(item)
                    }
                }
            }
            
            
        
            /// Stop picker
            Section("Stops") {
                Picker("Stops", selection: $metroInfo.stopSelectionPicker) {
                    ForEach(metroInfo.stopsForRoute) { item in
                        Text(item.Name)
                            .tag(item)
                    }
                }
            }
            
            
//            Section("Arrival times for this stop") {
//                Text(metroInfo.earliestArrivalForStop.ArrivalTime)
//            }
            
            Section("About") {
                Link("About the Developer", destination: K.linkedInURL)
                
                Link("Follow Developer on X (Formerly Twitter)", destination: K.twitterURL)
                
                Link("View Developer's GitHub", destination: K.gitHubURL)
            }
            .tint(.white)
            
        }
        .padding()
    }
}

#Preview {
    RouteAndStopPickerView()
        .environmentObject(MetroInfoViewModel())
}
