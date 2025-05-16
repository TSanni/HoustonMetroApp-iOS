//
//  RoutesModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/9/23.
//

import Foundation

struct RoutesModel: Codable {
    let value: [Route]
    
    static let allRoutesSample = RoutesModel(value: [Route(RouteId: "Ho414_4620_002", RouteName: "002", LongName: "Bellaire")])
}

struct Route: Codable, Identifiable, Hashable {
    
    var id: String {
        return RouteId
    }
    
    var fullName: String {
        return RouteName + " - " + LongName
    }
    
    let RouteId: String
    let RouteName: String
    let LongName: String
    
    static let routeSample = Route(RouteId: "Ho414_4620_002", RouteName: "002", LongName: "Bellaire")
}
