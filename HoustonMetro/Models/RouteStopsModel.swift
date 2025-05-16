//
//  RouteStopsModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/10/23.
//

import Foundation

struct RouteStopsModel: Codable {
    let value: [Stops]

    static let routeStopsSample = RouteStopsModel(value: [Stops(StopId: "Ho414_4620_94_B", DirectionId: "DirectionId", RouteId: "RouteId", Name: "No stops available", StopCode: "StopCode", Lat: 29.71137, Lon: -95.62941)])
}

struct Stops: Codable, Identifiable, Hashable {
    
    var id: String {
        return StopId + DirectionId
    }
    
    let StopId: String
    let DirectionId: String
    let RouteId: String
    let Name: String
    let StopCode: String
    let Lat: Double
    let Lon: Double
    
    static let stopsSample = Stops(StopId: "Ho414_4620_94_B", DirectionId: "DirectionId", RouteId: "RouteId", Name: "No stops available", StopCode: "StopCode", Lat: 29.71137, Lon: -95.62941)
}
