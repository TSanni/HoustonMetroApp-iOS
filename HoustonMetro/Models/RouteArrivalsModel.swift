//
//  RouteArrivalsModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/8/23.
//

import Foundation

struct RouteArrivalsModel: Codable {
    let value: [RouteArrivalsValueModel]
    
    static let routeArrivalsSample = RouteArrivalsModel( value: [RouteArrivalsValueModel.routeArrivalsValueSample] )
}
