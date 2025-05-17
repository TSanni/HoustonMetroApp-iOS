//
//  RoutesModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/9/23.
//

import Foundation

struct RoutesModel: Codable {
    let value: [Route]
    
    static let allRoutesSample = RoutesModel(value: [Route(routeId: "Ho414_4620_002", routeName: "002", longName: "Bellaire")])
}

struct Route: Codable, Identifiable, Hashable {
    
    var id: String {
        return routeId
    }
    
    var fullName: String {
        return routeName + " - " + longName
    }
    
    let routeId: String
    let routeName: String
    let longName: String
    
    static let routeSample = Route(routeId: "Ho414_4620_002", routeName: "002", longName: "Bellaire")
    
    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case routeName = "RouteName"
        case longName = "LongName"
    }
}
