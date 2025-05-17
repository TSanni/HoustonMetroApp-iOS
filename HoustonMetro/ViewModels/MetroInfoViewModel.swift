//
//  MetroInfoViewModel.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/11/23.
//

import Foundation
import Combine
import MapKit

class MetroInfoViewModel: ObservableObject {
    // These two published properties will work with SwiftUI picker views
    @Published var routeSelectionPicker: Route = Route.routeSample
    @Published var stopSelectionPicker: Stops = Stops.stopsSample
    
    // These three published properties will be updated with network calls and will work with model structs
    @Published var routes: RoutesModel = RoutesModel.allRoutesSample
    @Published var stopsForRoute: [Stops] = [Stops.stopsSample]
    @Published var earliestArrivalForStop: RouteArrivalsValueModel = RouteArrivalsValueModel.routeArrivalsValueSample
    
    // This published properties will work with the UI
    @Published var dataExists: Bool = false
    @Published  var date: String? = nil
    
    
    //These published properties will work with Map
    @Published var locations: [MapLocationsModel] = []
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.71137, longitude: -95.62941), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    private let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getAllRoutes()
        routePickerSubscriber()
        stopPickerSubscriber()
    }
    
    func getAllRoutes() {
        MetroManager.instance.getAllRoutes { [weak self] returnedRoutes in
            self?.routes = returnedRoutes
        }
    }
    
    /// This function subscribes to  @Published routeSelectionPicker and is called each time routeSelectionPicker is updated
    private func routePickerSubscriber() {
        print("Route selection picker subscriber activated")
        
        $routeSelectionPicker
            .sink { [weak self] route in
                print("ROUTE SELECTION PICKER VALUE: \(route)")
                
                self?.getAllStopsForRoute(routeId: route.routeName)
            }
            .store(in: &cancellables)
    }
    
    /// This function subscribes to @Published stopSelectionPicker and is called each time stopSelectionPicker is updated
    private func stopPickerSubscriber() {
        print("Stop selection picker subscriber activated")
        
        $stopSelectionPicker
            .sink { stop in
                self.locations = []
                
                MetroManager.instance.getAllArrivalsForRoute(routeId: self.routeSelectionPicker.routeName) { arrivals in
                    self.filterForEarliestArrival(arrivals: arrivals, stop: stop)
                }
                
                let latitude = stop.lat
                let longitude = stop.lon
                let stopName = stop.name
                let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self.mapRegion = MKCoordinateRegion(center: center, span: self.mapSpan)
                
                self.locations.append(MapLocationsModel(latitude: latitude, longitude: longitude, name: stopName))
                
            }
            .store(in: &cancellables)
    }
    
    /// Communicates with MetroManager to get all Stops for passed in routeId
    private func getAllStopsForRoute(routeId: String) {
        
        MetroManager.instance.getAllStopsForRoute(routeId: routeId) { [weak self] returnedStops in
            
            if returnedStops.value.isEmpty {
                print("\n\n\n NO STOPS!!!! \n\n\n")
                self?.dataExists = false
                self?.stopsForRoute = [Stops.stopsSample]
                self?.stopSelectionPicker = Stops.stopsSample
                
            } else {
                self?.stopsForRoute = returnedStops.value
                self?.stopSelectionPicker = returnedStops.value[0]
            }
        }
    }
}

extension MetroInfoViewModel {
    
    /// This function takes in all arrivals for a particular route and a specified stop, then filters to ensure the arrival's stopID and the stop's stopID are equal
    private func filterForEarliestArrival(arrivals: RouteArrivalsModel, stop: Stops) {
        var earliestArrivalsForStop: [RouteArrivalsValueModel] = []
        
        if arrivals.value.isEmpty {
            self.dataExists = false
            self.earliestArrivalForStop = RouteArrivalsValueModel.routeArrivalsValueSample
            return
        }
        
        let properStopsForArrival = arrivals.value.filter { arrival in
            arrival.stopId == stop.stopId
        }
        
        guard !properStopsForArrival.isEmpty else {
            self.dataExists = false
            self.earliestArrivalForStop = RouteArrivalsValueModel.routeArrivalsValueSample
            return
        }
        
        for i in properStopsForArrival {
            earliestArrivalsForStop.append(RouteArrivalsValueModel(
                isRealTime: i.isRealTime,
                directionText: i.directionText,
                arrivalId: i.arrivalId,
                agencyId: i.agencyId,
                agencyAbbreviation: i.agencyAbbreviation,
                serviceDate: i.serviceDate,
                localArrivalTime: getDate(stringedDate: i.localArrivalTime),
                localDepartureTime: getDate(stringedDate: i.localDepartureTime),
                utcArrivalTime: getDate(stringedDate: i.utcArrivalTime),
                utcDepartureTime: getDate(stringedDate: i.utcDepartureTime),
                destinationName: i.destinationName,
                destinationStopId: i.destinationStopId,
                directionId: i.directionId,
                direction: i.direction,
                routeId: i.routeId,
                serviceId: i.serviceId,
                stopId: i.stopId,
                tripId: i.tripId,
                localTripStartTime: getDate(stringedDate: i.localTripStartTime),
                localTripEndTime: getDate(stringedDate: i.localTripEndTime),
                stopName: i.stopName,
                stopSequence: i.stopSequence,
                routeName: i.routeName,
                routeType: i.routeType,
                delaySeconds: i.delaySeconds,
                vehicleID: i.vehicleID,
                carCount: i.carCount,
                frequency: i.frequency,
                confidenceLevel: i.confidenceLevel,
                status: i.status,
                destinationStopName: i.destinationStopName,
                arrivalTime: getDate(stringedDate: i.arrivalTime),
                scheduledTime: getDate(stringedDate: i.scheduledTime)
            )
            )
        }
        
        self.earliestArrivalForStop = earliestArrivalsForStop[0]
        self.dataExists = true
        self.date = formatDateToString(date: Date.now)
    }
    
    /// The metro API dates and times are hard to read. This function converts those dates to a readable format
    /// - Parameter stringedDate: The hard to read date is the value passed in
    /// - Returns: A String is returned as a readable date and time
    private func getDate(stringedDate: String) -> String {
        let dateFormatter = DateFormatter()
        
        /// confirm the date formate from the string passed in
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        /// convert the date string to a date object, else return an empty string
        guard let stringedDateToDate = dateFormatter.date(from: stringedDate) else { return ""}
        
        /// apply formatting to the date object
        dateFormatter.dateFormat = "h:mm a"
        
        /// convert the date object to a string
        let newDate = dateFormatter.string(from: stringedDateToDate)
        
        /// return the date string
        return newDate
    }
    
    /// This function converts a date object into a readable string object
    /// - Parameter date: The date object
    /// - Returns: Returns the time in string format Ex) 7:00 AM
    private func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
