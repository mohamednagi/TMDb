//
//  Endpoint.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

struct Endpoint {
    static let shared = Endpoint()
    
    private var baseURL = URL(string: "https://api.themoviedb.org/3/movie")
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmJkMTM5Y2QyMGMxOTk5ZGZmYWEyZWVkNzJkNWE4NiIsIm5iZiI6MTUyMDA3NzY5NS4zMjgsInN1YiI6IjVhOWE4YjdmYzNhMzY4MGI5NjAxYzcxMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._OUNQNPlY_oij17zaMhnBF3I0gfWavJE4trBnx16VNQ"
    
    private init(){}
    
    func setEndpoint(with endpoint: String) -> URL? {
        return baseURL?.appending(path: endpoint)
    }
    
    func getImageEndpoint() -> String {
        return imageBaseURL
    }
    
    func getAccessToken() -> String {
        return accessToken
    }
}
