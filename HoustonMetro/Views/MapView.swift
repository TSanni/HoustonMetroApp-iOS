//
//  MapView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/15/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var metroInfo: MetroInfoViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
                Map(coordinateRegion: $metroInfo.mapRegion, annotationItems: metroInfo.locations) { location in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    
                    
                    /*
                     
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        VStack(spacing: 0.0) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding(6)
                                .cornerRadius(36)
                            Image(systemName: "triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red)
                                .frame(width: 10, height: 10)
                                .rotationEffect(Angle(degrees: 180))
                                .offset(y: -9)
                                .padding(.bottom, 40)
                        }
                    }
                    
                    */
                }
        }
        .ignoresSafeArea()
    }
}



#Preview {
    MapView()
        .environmentObject(MetroInfoViewModel())
}
