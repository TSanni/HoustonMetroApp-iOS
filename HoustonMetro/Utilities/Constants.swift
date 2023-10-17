//
//  Constants.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/9/23.
//

import Foundation

struct K {
    /// API Key stored in plist
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey")
    
    /// All Routes URL
    static let allRoutesURL = "https://api.ridemetro.org/data/Routes?subscription-key="
    
    /// Route Arrivals URL parts
    static let routeArrivalsURLStringFirstPart = "https://api.ridemetro.org/data/Routes"
    static let routeArrivalsURLStringSecondPart = "/Arrivals?subscription-key="
    
    /// Route Stops URL parts
    static let routeStopsURLStringFirstPart = "https://api.ridemetro.org/data/Routes"
    static let routesStopsURLStringSecondPart = "/Stops?subscription-key="
    
    
    /// Function to concatenate  routeArrivals URL parts
    /// - Parameter routeID: will be a unique identifier to get proper route
    /// - Returns: returns a string of a URL for the route arrivals
    static func routeArrivalsURL(routeID: String) -> String {
        return "\(routeArrivalsURLStringFirstPart)('\(routeID)')\(routeArrivalsURLStringSecondPart)"
    }
    
    
    /// Function to concatenate  routeStops URL parts
    /// - Parameter routeID: will be a unique identifier to get proper route stops
    /// - Returns: returns a string of a URL for the route stops
    static func routeStopsURL(routeID: String) -> String {
        return "\(routeStopsURLStringFirstPart)('\(routeID)')\(routesStopsURLStringSecondPart)"
    }
}
