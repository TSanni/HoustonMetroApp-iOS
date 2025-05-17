//
//  RouteArrivalsValueModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 5/16/25.
//

import Foundation

struct RouteArrivalsValueModel: Codable {
    let isRealTime: Bool
    let directionText: String
    let arrivalId: String
    let agencyId: String
    let agencyAbbreviation: String
    let serviceDate, localArrivalTime, localDepartureTime, utcArrivalTime: String
    let utcDepartureTime: String
    let destinationName: String
    let destinationStopId: String
    let directionId: String
    let direction: Double
    let routeId: String
    let serviceId: String
    let stopId: String
    let tripId: String
    let localTripStartTime, localTripEndTime: String
    let stopName: String
    let stopSequence: Double
    let routeName: String
    let routeType: String
    let delaySeconds: Double?
    let vehicleID: String?
    let carCount, frequency: Double
    let confidenceLevel, status: String?
    let destinationStopName: String
    let arrivalTime: String
    let scheduledTime: String
    
    static let routeArrivalsValueSample = RouteArrivalsValueModel(
        isRealTime: true,
        directionText: "",
        arrivalId: "",
        agencyId: "",
        agencyAbbreviation: "",
        serviceDate: "",
        localArrivalTime: "",
        localDepartureTime: "",
        utcArrivalTime: "",
        utcDepartureTime: "",
        destinationName: "",
        destinationStopId: "",
        directionId: "",
        direction: 0,
        routeId: "",
        serviceId: "",
        stopId: "",
        tripId: "",
        localTripStartTime: "",
        localTripEndTime: "",
        stopName: "",
        stopSequence: 0,
        routeName: "",
        routeType: "",
        delaySeconds: 0,
        vehicleID: nil,
        carCount: 0,
        frequency: 0,
        confidenceLevel: nil,
        status: nil,
        destinationStopName: "",
        arrivalTime: "No arrival times",
        scheduledTime: ""
    )
    
    enum CodingKeys: String, CodingKey {
        case isRealTime = "IsRealTime"
        case directionText = "DirectionText"
        case arrivalId = "ArrivalId"
        case agencyId = "AgencyId"
        case agencyAbbreviation = "AgencyAbbreviation"
        case serviceDate = "ServiceDate"
        case localArrivalTime = "LocalArrivalTime"
        case localDepartureTime = "LocalDepartureTime"
        case utcArrivalTime = "UtcArrivalTime"
        case utcDepartureTime = "UtcDepartureTime"
        case destinationName = "DestinationName"
        case destinationStopId = "DestinationStopId"
        case directionId = "DirectionId"
        case direction = "Direction"
        case routeId = "RouteId"
        case serviceId = "ServiceId"
        case stopId = "StopId"
        case tripId = "TripId"
        case localTripStartTime = "LocalTripStartTime"
        case localTripEndTime = "LocalTripEndTime"
        case stopName = "StopName"
        case stopSequence = "StopSequence"
        case routeName = "RouteName"
        case routeType = "RouteType"
        case delaySeconds = "DelaySeconds"
        case vehicleID = "VehicleID"
        case carCount = "CarCount"
        case frequency = "Frequency"
        case confidenceLevel = "ConfidenceLevel"
        case status = "Status"
        case destinationStopName = "DestinationStopName"
        case arrivalTime = "ArrivalTime"
        case scheduledTime = "ScheduledTime"
    }
}
