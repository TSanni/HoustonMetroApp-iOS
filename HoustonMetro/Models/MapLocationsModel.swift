//
//  MapLocationsModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/21/23.
//

import Foundation

struct MapLocationsModel: Identifiable {
    let id = UUID()
    
    let latitude: Double
    let longitude: Double
    
    let name: String
    
    static let mapLocationsSample = MapLocationsModel(latitude: 29.71137, longitude: -95.62941, name: "")
}

