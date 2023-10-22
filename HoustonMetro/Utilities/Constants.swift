//
//  Constants.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/9/23.
//

import Foundation
import SwiftUI


struct K {
    
    static let successColor = Color(uiColor: #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))
    static let failColor = Color(uiColor: #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
    
    static let linkedInURL = URL(string: "https://www.linkedin.com/in/tomas-sanni")!
    static let gitHubURL = URL(string: "https://github.com/TSanni")!
    static let twitterURL = URL(string: "https://x.com/tomassanni?s=21&t=eUgqu9NfNgMqW4f6Kqvr1g")!

    /// API Key stored in plist
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey")
    
    static let routeIDPrefix = "Ho414_4620_"
    
    /// All Routes URL
    static let allRoutesURL = "https://api.ridemetro.org/data/Routes?subscription-key="
    
    /// All Stops URL
    static let allStopsURL = "https://api.ridemetro.org/data/Stops?subscription-key="
    
    /// Route Arrivals URL parts
    static let routeArrivalsURLStringFirstPart = "https://api.ridemetro.org/data/Routes"
    static let routeArrivalsURLStringSecondPart = "/Arrivals?subscription-key="
    
    /// Route Stops URL parts
    static let routeStopsURLStringFirstPart = "https://api.ridemetro.org/data/Routes"
    static let routesStopsURLStringSecondPart = "/Stops?subscription-key="
    
    
    static let allRouteInfoURLFirstPart = "https://api.ridemetro.org/data/Routes"
    static let allRouteInfoURLSecondPart = "?$expand=Stops,Arrivals&subscription-key="

    
    /// Function to concatenate  routeArrivals URL parts
    /// - Parameter routeID: will be a unique identifier to get proper route
    /// - Returns: returns a string of a URL for the route arrivals
    static func routeArrivalsURL(routeID: String) -> String {
        return "\(routeArrivalsURLStringFirstPart)('\(routeIDPrefix)\(routeID)')\(routeArrivalsURLStringSecondPart)"
    }
    
    
    /// Function to concatenate  routeStops URL parts
    /// - Parameter routeID: will be a unique identifier to get proper route stops
    /// - Returns: returns a string of a URL for the route stops
    static func routeStopsURL(routeID: String) -> String {
        return "\(routeStopsURLStringFirstPart)('\(routeIDPrefix)\(routeID)')\(routesStopsURLStringSecondPart)"
    }
    
    static func allRouteInfoURL(routeID: String) -> String {
        return  "\(allRouteInfoURLFirstPart)('\(routeIDPrefix)\(routeID)')\(allRouteInfoURLSecondPart)"
    }
}
