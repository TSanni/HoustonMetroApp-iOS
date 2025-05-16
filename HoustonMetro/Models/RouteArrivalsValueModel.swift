//
//  RouteArrivalsValueModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 5/16/25.
//

import Foundation

struct RouteArrivalsValueModel: Codable {
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
    
    static let routeArrivalsValueSample = RouteArrivalsValueModel(
        IsRealTime: true,
        DirectionText: "",
        ArrivalId: "",
        AgencyId: "",
        AgencyAbbreviation: "",
        ServiceDate: "",
        LocalArrivalTime: "",
        LocalDepartureTime: "",
        UtcArrivalTime: "",
        UtcDepartureTime: "",
        DestinationName: "",
        DestinationStopId: "",
        DirectionId: "",
        Direction: 0,
        RouteId: "",
        ServiceId: "",
        StopId: "",
        TripId: "",
        LocalTripStartTime: "",
        LocalTripEndTime: "",
        StopName: "",
        StopSequence: 0,
        RouteName: "",
        RouteType: "",
        DelaySeconds: 0,
        VehicleID: nil,
        CarCount: 0,
        Frequency: 0,
        ConfidenceLevel: nil,
        Status: nil,
        DestinationStopName: "",
        ArrivalTime: "No arrival times",
        ScheduledTime: ""
    )
}
