////
////  InfoForRouteModel.swift
////  HoustonMetro
////
////  Created by Tomas Sanni on 10/18/23.
////
//
//import Foundation
//
//
//struct InfoForRouteModel: Codable {
//    
//    let value: [AllValues]
//    
//}
//
//struct AllValues: Codable, Identifiable {
//    
//    let id = UUID()
//    
//    let RouteId: String
//    let AgencyAbbreviation: String
//    let FinalStop0Id: String?
//    let FinalStop1Id: String?
//    let RouteName: String
//    let LongName: String
//    let RouteType: String
//
//    let DataSource: String
//    
//    let Stops: [Stops]
//    let Arrivals: [Arrivals]
//    
//    static let AllValuesHolder = AllValues(RouteId: "", AgencyAbbreviation: "", FinalStop0Id: nil, FinalStop1Id: nil, RouteName: "", LongName: "", RouteType: "", DataSource: "", Stops: [], Arrivals: [])
//    
//    
//}
//
//struct Stops: Codable, Identifiable, Hashable {
//    var id: String {
//        return Id
//    }
//    
//    let Id: String
//    
//    let StopId: String
//    let DirectionId: String
//    let RouteId: String
//    let AgencyId: String
//    let Name: String
//    let StopCode: String
//    let Lat: Double
//    let Lon: Double
//    let Ordinal: Double
//    let OrdinalOnDirection: Double
//    
//    static let StopsHolder = Stops(
//        Id: "Ho414_4620_94_B_Ho414_4620_002_0",
//        StopId: "Ho414_4620_94_B",
//        DirectionId: "Ho414_4620_002_0",
//        RouteId: "Ho414_4620_002",
//        AgencyId: "Ho414",
//        Name: "94 - Mission Bend Transit Center B",
//        StopCode: "94",
//        Lat: 29.71137,
//        Lon: -95.62941,
//        Ordinal: 1.0,
//        OrdinalOnDirection: 1.0
//    )
//}
//
//struct Arrivals: Codable, Identifiable {
//    
//    var id: String {
//        return ArrivalId
//    }
//    
//    let IsRealTime: Bool
//    let DirectionText: String
//    let ArrivalId: String
//    let AgencyId: String
//    let AgencyAbbreviation: String
//    let ServiceDate, LocalArrivalTime, LocalDepartureTime, UtcArrivalTime: String
//    let UtcDepartureTime: String
//    let DestinationName: String
//    let DestinationStopId: String
//    let DirectionId: String
//    let Direction: Double
//    let RouteId: String
//    let ServiceId: String
//    let StopId: String
//    let TripId: String
//    let LocalTripStartTime, LocalTripEndTime: String
//    let StopName: String
//    let StopSequence: Double
//    let RouteName: String
//    let RouteType: String
//    let DelaySeconds: Double?
//    let VehicleID: String?
//    let CarCount, Frequency: Double
//    let ConfidenceLevel, Status: String?
//    let DestinationStopName: String
//    let ArrivalTime: String
//    let ScheduledTime: String
//    
//    
//    
//    static let ArrivalsHolder = Arrivals(
//        IsRealTime: false,
//        DirectionText: "",
//        ArrivalId: "",
//        AgencyId: "",
//        AgencyAbbreviation: "",
//        ServiceDate: "",
//        LocalArrivalTime: "",
//        LocalDepartureTime: "",
//        UtcArrivalTime: "",
//        UtcDepartureTime: "",
//        DestinationName: "",
//        DestinationStopId: "",
//        DirectionId: "",
//        Direction: 0,
//        RouteId: "",
//        ServiceId: "",
//        StopId: "", 
//        TripId: "",
//        LocalTripStartTime: "",
//        LocalTripEndTime: "",
//        StopName: "",
//        StopSequence: 0,
//        RouteName: "",
//        RouteType: "",
//        DelaySeconds: nil,
//        VehicleID: nil,
//        CarCount: 0,
//        Frequency: 0,
//        ConfidenceLevel: nil,
//        Status: nil,
//        DestinationStopName: "",
//        ArrivalTime: "",
//        ScheduledTime: ""
//    )
//    
//    
//    
//}
