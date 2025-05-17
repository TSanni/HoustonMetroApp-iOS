//
//  RouteAndStopPickerView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/11/23.
//

import SwiftUI

struct RouteAndStopPickerView: View {
    @EnvironmentObject var metroInfo: MetroInfoViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack {
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
                            Text(item.name)
                                .tag(item)
                        }
                    }
                }
                
                Section("About") {
                    Link("About the Developer", destination: K.linkedInURL)
                    
                    Link("Follow Developer on X (Formerly Twitter)", destination: K.twitterURL)
                    
                    Link("View Developer's GitHub", destination: K.gitHubURL)
                }
                .tint(.white)
            }
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.down")
                    .font(.largeTitle)
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

