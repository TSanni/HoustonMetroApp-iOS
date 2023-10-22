////
////  StopsModel.swift
////  HoustonMetro
////
////  Created by Tomas Sanni on 10/12/23.
////
//
//import Foundation
//
//
//struct StopsModel: Codable {
//    let value: [AllValues]
//    
//    static let allStopsHolder = StopsModel(value: [AllValues(
//        StopId: "",
//        AgencyId: "",
//        Name: "",
//        StopCode: "",
//        DataSource: "",
//        Lat: 0,
//        Lon: 0,
//        DistanceFromCenter: 0
//    )])
//    
//}
//
//
//struct AllValues: Codable, Identifiable {
//    
//    var id: String {
//        return StopId
//    }
//    
//    let StopId: String
//    let AgencyId: String
//    let Name: String
//    let StopCode: String
//    let DataSource: String
//    let Lat: Double
//    let Lon: Double
//    let DistanceFromCenter: Double
//}
//
