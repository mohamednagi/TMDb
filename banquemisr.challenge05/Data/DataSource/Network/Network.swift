//
//  Network.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import Foundation

protocol Network {
    func fetchMovies(in query: MoviesListType) async -> Result<MoviesBaseModel,FetchErrorType>
    func fetchMovieDetails(with id: Int) async -> Result<MovieDetailsBaseModel,FetchErrorType>
}

class NetworkImpl: Network {
    
    private func getRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Endpoint.shared.getAccessToken())"
        ]
        return request
    }
    
    func fetchMovies(in query: MoviesListType) async -> Result<MoviesBaseModel,FetchErrorType> {
        if !Reachability.shared.isReachableNow() {
            return Result.failure(.noNetwork)
        }
        // Build fetch url
        guard let movieURL = Endpoint.shared.setEndpoint(with: query.rawValue) else {return Result.failure(FetchErrorType.badURL)}
        
        do {
            // Fetch data
            let (data, response) = try await URLSession.shared.data(for: getRequest(for: movieURL))
            
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
    
    func fetchMovieDetails(with id: Int) async -> Result<MovieDetailsBaseModel,FetchErrorType> {
        if !Reachability.shared.isReachableNow() {
            return Result.failure(.noNetwork)
        }
        // Build fetch url
        guard let movieDetailsURL = Endpoint.shared.setEndpoint(with: "\(id)") else {return Result.failure(FetchErrorType.badURL)}
        
        do {
            // Fetch data
            let (data, response) = try await URLSession.shared.data(for: getRequest(for: movieDetailsURL))
            
            // Handle response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return Result.failure(FetchErrorType.badResponse)
            }
            
            // Decode data
            let movieDetails = try JSONDecoder().decode(MovieDetailsBaseModel.self, from: data)
            
            // Return quote
            return Result.success(movieDetails)
        }catch {
            return Result.failure(FetchErrorType.noData)
        }
    }
}
