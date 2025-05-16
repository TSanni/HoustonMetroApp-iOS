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
                }
        }
        .ignoresSafeArea()
    }
}



#Preview {
    MapView()
        .environmentObject(MetroInfoViewModel())
}
