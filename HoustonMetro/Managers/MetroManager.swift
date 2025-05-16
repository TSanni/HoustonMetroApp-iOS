//
//  MetroManager.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/12/23.
//

import Foundation
import Combine

class MetroManager {
    
    static let instance = MetroManager()
    
    var cancellables = Set<AnyCancellable>()
    
    /// Gets all routes and returns a RoutesModel
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
    
    /// Gets all stops for the passed in routeId and returns a RouteStopsModel
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
            .replaceError(with: RouteStopsModel.routeStopsSample)
            .sink { completion in
                switch completion {
                    case .finished:
                        print("FINISHED DECODING RouteStopsModel WITH PASSED IN ROUTEID")
                    case .failure(let error):
                        print("THERE WAS AN ERROR DECODING RouteStopsModel: \(error)")
                        
                }
            } receiveValue: { returnedStops in
                completion(returnedStops)
            }
            .store(in: &cancellables)
    }
    
    /// Gets all arrivals for the passed in routeId and returns a RouteArrivalsModel
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
                }
            } receiveValue: { returnedArrivals in
                completion(returnedArrivals)
            }
            .store(in: &cancellables)
    }
}
