//
//  RouteStopsModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/10/23.
//

import Foundation

struct RouteStopsModel: Codable {
    let value: [Stops]

    static let routeStopsSample = RouteStopsModel(value: [Stops(stopId: "Ho414_4620_94_B", directionId: "DirectionId", routeId: "RouteId", name: "No stops available", stopCode: "StopCode", lat: 29.71137, lon: -95.62941)])
}

struct Stops: Codable, Identifiable, Hashable {
    
    var id: String {
        return stopId + directionId
    }
    
    let stopId: String
    let directionId: String
    let routeId: String
    let name: String
    let stopCode: String
    let lat: Double
    let lon: Double
    
    static let stopsSample = Stops(stopId: "Ho414_4620_94_B", directionId: "DirectionId", routeId: "RouteId", name: "No stops available", stopCode: "StopCode", lat: 29.71137, lon: -95.62941)
    
    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case directionId = "DirectionId"
        case routeId = "RouteId"
        case name = "Name"
        case stopCode = "StopCode"
        case lat = "Lat"
        case lon = "Lon"
    }
}

enum CodingKeys: String, CodingKey {
    case routeId = "RouteId"
    case routeName = "RouteName"
    case longName = "LongName"
}
