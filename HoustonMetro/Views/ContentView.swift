//
//  ContentView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/8/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var metroInfo = MetroInfoViewModel()
    @State private var showSettings: Bool = false
    @State private var showMap: Bool = false
    @State private var date: Date? = nil
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
                        .environmentObject(metroInfo)

                        .padding()

                }
            } else {
                Text("--")
                    .font(.largeTitle)
                    .bold()

            }
            

            
            Spacer()
            
            if !metroInfo.dataExists {
                VStack {
                    Text("No upcoming arrivals found. Please try another stop or route")
                        .multilineTextAlignment(.center)
                }
            } else {
                if let date = date {
                    Text("Last checked: \(date)")
                        .multilineTextAlignment(.center)

                }
            }
            
        }
        .onReceive(metroInfo.$dataExists) { dataResult in
            if dataResult {
                date = Date.now
            }
        }
        .padding()
        .background {
            metroInfo.dataExists ? K.successColor.ignoresSafeArea() : K.failColor.ignoresSafeArea()
        }
        .sheet(isPresented: $showSettings) {
            RouteAndStopPickerView()
                .environmentObject(metroInfo)
        }
        .sheet(isPresented: $showMap) {
            MapView()
                .environmentObject(metroInfo)
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
    NavigationView {
        ContentView()
            .environmentObject(MetroInfoViewModel())
    }
}
