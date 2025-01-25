//
//  MockMoviesRepoImpl.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Foundation
@testable import banquemisr_challenge05

class MockMoviesRepoImpl: MoviesRepo {
    var result: Result<[Results], FetchErrorType>?
    
    func fetchMovies(in query: MoviesListType) async -> Result<[Results], FetchErrorType> {
        switch result {
        case .success(let value):
            return .success(value)
        case .failure:
            return .failure(.noData)
        case .none:
            return .failure(.badResponse)
        }
    }
}
