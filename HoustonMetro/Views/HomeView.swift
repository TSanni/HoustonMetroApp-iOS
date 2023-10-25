//
//  HomeView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/22/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var metroInfo: MetroInfoViewModel

    @State private var showSettings: Bool = false
    @State private var showMap: Bool = false

    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Route \(metroInfo.routeSelectionPicker.RouteName)")
                    .font(.largeTitle)
                    .bold()
                Text(metroInfo.stopSelectionPicker.Name)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            if metroInfo.dataExists {
                VStack {
                    Text("Next arrival at... ")
                        .font(.headline)
                    
                    Text(metroInfo.earliestArrivalForStop.ArrivalTime)
                        .font(.largeTitle)
                        .bold()
                    
                    BusAnimationView()
                        .padding()
                }
                
                Spacer()
                
                if let date = metroInfo.date {
                    Text("Last checked: \(date)")
                        .multilineTextAlignment(.center)
                    
                }
                
            } else {
                VStack {
                    Text("--")
                        .font(.largeTitle)
                        .bold()
                    
                    
                    Text("No upcoming arrivals found. Please try another stop or route")
                        .multilineTextAlignment(.center)
                    
                }
                
                Spacer()
            }
            
            
        }
        .padding()
        .background {
            metroInfo.dataExists ? K.successColor.ignoresSafeArea() : K.failColor.ignoresSafeArea()
        }
        .sheet(isPresented: $showSettings) {
            NavigationView {
                RouteAndStopPickerView()
                    .environmentObject(metroInfo)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                
                NavigationLink {
                    MapView()
                        .environmentObject(metroInfo)
                } label: {
                    Image(systemName: "map.fill")
                    
                }
                .tint(.white)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "slider.vertical.3")
                }
                .tint(.white)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MetroInfoViewModel())
        .environmentObject(NetworkManager())
}
