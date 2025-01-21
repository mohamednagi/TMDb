//
//  FetchMoviesImpl.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

class FetchMoviesRepoImpl: FetchMoviesRepo {
    
    private enum FetchError: Error {
        case badResponse
    }
    
    init(){}
    
    
    func fetchMovies(in query: String) async throws -> [MoviesBaseModel] {
        // Build fetch url
        guard let movieURL = Endpoint.shared.setEndpoint(with: query) else {return []}
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: movieURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let movies = try JSONDecoder().decode([MoviesBaseModel].self, from: data)
        
        // Return quote
        return movies
    }
    
    
}
