//
//  NetworkManager.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/12/23.
//

import Foundation
import Combine
//TODO: Update function descriptions

class NetworkManager {
    
    static let instance = NetworkManager()
    
    var cancellables = Set<AnyCancellable>()
    
    
    /// Uses networking to get all routes from a URL, then assigns that value to @Published var routes
    func getAllRoutes(completion: @escaping(_ returnedRoutes: RoutesModel) -> Void)  {
        print("getAllRoutes method called")
        
        guard let apiKey = K.apiKey else { return }
        guard let url = URL(string: "\(K.allRoutesURL)\(apiKey)") else { return }
        
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: RoutesModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                    case .finished:
                        print("FINISHED DECODING RoutesModel AND GOT ALL ROUTES")
                    case .failure(let error):
                        print("THERE WAS AN ERROR DECODING RoutesModel: \(error)")
                        
                }
            } receiveValue: { returnedRoutes in
                completion(returnedRoutes)
            }
            .store(in: &cancellables)
        
        
    }
    
    
    /// Uses networking to get all stops for a particular route
    /// - Parameter routeId: The routeID that will come from the MetroAPI
    func getAllStopsForRoute(routeId: String, completion: @escaping(_ returnedStops: RouteStopsModel) -> Void)  {
        print("getAllStopsForRoute method called!")
        
        guard let apiKey = K.apiKey else { return }
        let urlString = K.routeStopsURL(routeID: routeId)
        
        guard let url = URL(string: "\(urlString)\(apiKey)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {                    
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: RouteStopsModel.self, decoder: JSONDecoder())
            .replaceError(with: RouteStopsModel.RouteStopsModelHolder)
            .sink { completion in
                switch completion {
                    case .finished:
                        print("FINISHED DECODING RouteStopsModel WITH PASSED IN ROUTEID")
                    case .failure(let error):
                        print("THERE WAS AN ERROR DECODING RouteStopsModel: \(error)")
                        
                }
            } receiveValue: { returnedStops in
                print("\n\n\n\n RETURNED STOPS: \(returnedStops) \n\n\n\n\n")
                completion(returnedStops)
            }
            .store(in: &cancellables)
        
        
    }
    
    
    
    
    
    
    /// This function will get all arrival for the specified routeId , then assign the earliest arrival time to @Published var nextArrivalTimeForChosenStop.
    /// If empty, @Published var nextArrivalTimeForChosenStop will be assigned "No upcoming arrivals"
    /// - Parameters:
    ///   - routeId: this will be used in the network call to get all arrivals for a particular route
    func getAllArrivalsForRoute(routeId: String, completion: @escaping (_ arrivals: RouteArrivalsModel) -> Void) {
        print("getAllArrivalsForRoute method called!")
        
        guard let apiKey = K.apiKey else { return }
        let urlString = K.routeArrivalsURL(routeID: routeId)
        
        guard let url = URL(string: "\(urlString)\(apiKey)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: RouteArrivalsModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                    case .finished:
                        print("FINISHED DECODING RouteArrivalsModel.. GOT ALL ARRIVALS FOR PASSED IN ROUTEID")
                    case .failure(let error):
                        print("THERE WAS AN ERROR DECODING RouteArrivalsModel: \(error)")
//                        throw NetworkErrors.failedToLoadArrivals
                }
            } receiveValue: { returnedArrivals in
                completion(returnedArrivals)
            }
            .store(in: &cancellables)
        
        
    }
    
    
}




enum NetworkErrors: Error {
    case failedToLoadRoutes
    case failedToLoadStops
    case failedToLoadArrivals
    
    var description: String {
        switch self {
            case .failedToLoadRoutes:
                return "Failed to load routes. Check internet connection."
            case .failedToLoadStops:
                return "Failed to load stops. Check internet connection."
            case .failedToLoadArrivals:
                return "Failed to load arrivals. Check internet connection."
        }
    }
}


