//
//  RoutesModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/9/23.
//

import Foundation


struct RoutesModel: Codable {
    let value: [AllRoutes]
    
    static let AllRoutesModelHolder = RoutesModel(value: [AllRoutes(RouteId: "RouteId", RouteName: "002", LongName: "Bellaire")])
}


struct AllRoutes: Codable, Identifiable {
    
    var id: String {
        return RouteName + " - " + LongName
    }
    
    
    let RouteId: String
    let RouteName: String
    let LongName: String
}
