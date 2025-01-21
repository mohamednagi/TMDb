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
    private init(){}
    
    func setEndpoint(with endpoint: String) -> URL? {
        return baseURL?.appending(path: endpoint)
    }
    
}
