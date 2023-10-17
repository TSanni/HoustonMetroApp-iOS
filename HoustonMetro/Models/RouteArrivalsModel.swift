//
//  RouteArrivalsModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/8/23.
//

import Foundation


struct RouteArrivalsModel: Codable {
    let value: [RouteValue]
}


struct RouteValue: Codable {
    let IsRealTime: Bool
    let DirectionText: String
    let ArrivalId: String
    let AgencyId: String
    let AgencyAbbreviation: String
    let ServiceDate, LocalArrivalTime, LocalDepartureTime, UtcArrivalTime: String
    let UtcDepartureTime: String
    let DestinationName: String
    let DestinationStopId: String
    let DirectionId: String
    let Direction: Double
    let RouteId: String
    let ServiceId: String
    let StopId: String
    let TripId: String
    let LocalTripStartTime, LocalTripEndTime: String
    let StopName: String
    let StopSequence: Double
    let RouteName: String
    let RouteType: String
    let DelaySeconds: Double?
    let VehicleID: String?
    let CarCount, Frequency: Double
    let ConfidenceLevel, Status: String?
    let DestinationStopName: String
    let ArrivalTime: String
    let ScheduledTime: String
    
    
}
