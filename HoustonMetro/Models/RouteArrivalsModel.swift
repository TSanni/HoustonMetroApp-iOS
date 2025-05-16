//
//  RouteArrivalsModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/8/23.
//

import Foundation


struct RouteArrivalsModel: Codable {
    let value: [RouteArrivalsValueModel]
    
    
    static let RouteArrivalModelHolder = RouteArrivalsModel(value:
                                                                [RouteArrivalsValueModel(
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
                                                                ]
    )
}
