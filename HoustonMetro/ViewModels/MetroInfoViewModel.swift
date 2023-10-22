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
    @Published var routeSelectionPicker: Route = Route.RouteHolder
    @Published var stopSelectionPicker: Stops = Stops.StopsHolder

    // These three published properties will be updated with network calls and will work with model structs
    @Published var routes: RoutesModel = RoutesModel.AllRoutesModelHolder
    @Published var stopsForRoute: [Stops] = [Stops.StopsHolder]
    @Published var earliestArrivalForStop: RouteArrivalsValue = RouteArrivalsValue.RouteArrivalsValueHolder
    
    // This published properties will work with the UI
    @Published var dataExists: Bool = false
    
    //These published properties will work with Map
    @Published var locations: [MapLocationsModel] = []
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.71137, longitude: -95.62941), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    private let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    var cancellables = Set<AnyCancellable>()

    
    init() {
        NetworkManager.instance.getAllRoutes { [weak self] returnedRoutes in
            self?.routes = returnedRoutes
        }
        

        routePickerSubscriber()
        stopPickerSubscriber()
    }
    
    private func getAllStopsForRoute(routeId: String) {
        
        NetworkManager.instance.getAllStopsForRoute(routeId: routeId) { [weak self] returnedStops in
            
            if returnedStops.value.isEmpty {
                print("\n\n\n NO STOPS!!!! \n\n\n")
                self?.dataExists = false
                self?.stopsForRoute = [Stops.StopsHolder]
                self?.stopSelectionPicker = Stops.StopsHolder

            } else {
//                self?.dataExists = true
                self?.stopsForRoute = returnedStops.value
                self?.stopSelectionPicker = returnedStops.value[0]
            }
            
        }
    }

    
    /// This function subscribes to @Published var routeSelectionPicker
    ///
    /// Passes in the route to getAllStopsForRoute(routeId:) method each time $routeSelectionPicker is updated
    private func routePickerSubscriber() {
        print("Route selection picker subscriber activated")
        
        $routeSelectionPicker
            .sink { [weak self] route in
                print("ROUTE SELECTION PICKER VALUE: \(route)")
                
                self?.getAllStopsForRoute(routeId: route.RouteName)
            }
            .store(in: &cancellables)
    }
    
    
    
    /// This function subscribes to @Published var stopSelectionPicker
    ///
    /// Passes in the current value for @Published var routeSelectionPicker AND also the value for @Published var stopSelectionPicker
    private func stopPickerSubscriber() {
        print("Stop selection picker subscriber activated")

        $stopSelectionPicker
            .sink { stop in
                self.locations = []
                
                NetworkManager.instance.getAllArrivalsForRoute(routeId: self.routeSelectionPicker.RouteName) { arrivals in
                    self.filterForEarliestArrival(arrivals: arrivals, stop: stop)
                }
                
                //TODO: Get map coordinates for stop
                let latitude = stop.Lat
                let longitude = stop.Lon
                let stopName = stop.Name
                let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self.mapRegion = MKCoordinateRegion(center: center, span: self.mapSpan)
                
                self.locations.append(MapLocationsModel(latitude: latitude, longitude: longitude, name: stopName))
                
            }
            .store(in: &cancellables)
    }
    

}


extension MetroInfoViewModel {
    
    private func filterForEarliestArrival(arrivals: RouteArrivalsModel, stop: Stops) {
        var earliestArrivalsForStop: [RouteArrivalsValue] = []
        
        if arrivals.value.isEmpty {
            self.dataExists = false
            self.earliestArrivalForStop = RouteArrivalsValue.RouteArrivalsValueHolder
            return
        }
        
        
        let properStopsForArrival = arrivals.value.filter { arrival in
            arrival.StopId == stop.StopId
        }
        
        guard !properStopsForArrival.isEmpty else {
            self.dataExists = false
            self.earliestArrivalForStop = RouteArrivalsValue.RouteArrivalsValueHolder
            return
        }
        
        for i in properStopsForArrival {
            earliestArrivalsForStop.append(RouteArrivalsValue(
                IsRealTime: i.IsRealTime,
                DirectionText: i.DirectionText,
                ArrivalId: i.ArrivalId,
                AgencyId: i.AgencyId,
                AgencyAbbreviation: i.AgencyAbbreviation,
                ServiceDate: i.ServiceDate,
                LocalArrivalTime: getDate(stringedDate: i.LocalArrivalTime),
                LocalDepartureTime: getDate(stringedDate: i.LocalDepartureTime),
                UtcArrivalTime: getDate(stringedDate: i.UtcArrivalTime),
                UtcDepartureTime: getDate(stringedDate: i.UtcDepartureTime),
                DestinationName: i.DestinationName,
                DestinationStopId: i.DestinationStopId,
                DirectionId: i.DirectionId,
                Direction: i.Direction,
                RouteId: i.RouteId,
                ServiceId: i.ServiceId,
                StopId: i.StopId,
                TripId: i.TripId,
                LocalTripStartTime: getDate(stringedDate: i.LocalTripStartTime),
                LocalTripEndTime: getDate(stringedDate: i.LocalTripEndTime),
                StopName: i.StopName,
                StopSequence: i.StopSequence,
                RouteName: i.RouteName,
                RouteType: i.RouteType,
                DelaySeconds: i.DelaySeconds,
                VehicleID: i.VehicleID,
                CarCount: i.CarCount,
                Frequency: i.Frequency,
                ConfidenceLevel: i.ConfidenceLevel,
                Status: i.Status,
                DestinationStopName: i.DestinationStopName,
                ArrivalTime: getDate(stringedDate: i.ArrivalTime),
                ScheduledTime: getDate(stringedDate: i.ScheduledTime)
            )
            )
        }
        
        
        
        self.earliestArrivalForStop = earliestArrivalsForStop[0]
        self.dataExists = true

//        for i in earliestArrivalsForStop {
//            print("\nARRIVAL VALUE: \(i)\n")
//        }
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
    
    
}
