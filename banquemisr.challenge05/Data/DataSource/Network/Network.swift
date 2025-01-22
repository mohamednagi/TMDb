//
//  Network.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import Foundation

protocol Network {
    func fetchMovies(in query: MoviesListType) async -> Result<MoviesBaseModel,FetchErrorType>
}

class NetworkImpl: Network {
    
    func fetchMovies(in query: MoviesListType) async -> Result<MoviesBaseModel,FetchErrorType> {
        // Build fetch url
        guard let movieURL = Endpoint.shared.setEndpoint(with: query.rawValue) else {return Result.failure(FetchErrorType.badURL)}
        
        var request = URLRequest(url: movieURL)
//        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(Endpoint.shared.getAccessToken())"
        ]
        
        do {
            // Fetch data
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Handle response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return Result.failure(FetchErrorType.badResponse)
            }
            
            // Decode data
            let movies = try JSONDecoder().decode(MoviesBaseModel.self, from: data)
            
            // Return quote
            return Result.success(movies)
        }catch {
            return Result.failure(FetchErrorType.noData)
        }
    }
}
