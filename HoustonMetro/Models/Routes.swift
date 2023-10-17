//
//  Routes.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/9/23.
//

import Foundation


struct Routes: Codable {
    let value: [AllRoutes]
    
    static let AllRoutesModelHolder = Routes(value: [AllRoutes(RouteId: "RouteId", RouteName: "002", LongName: "LongName")])
}


struct AllRoutes: Codable, Identifiable {
    
    var id: String {
        return RouteId
    }
    
    
    let RouteId: String
    let RouteName: String
    let LongName: String
}
