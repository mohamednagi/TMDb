//
//  MockMovieDetailsRepoImpl.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Foundation
@testable import banquemisr_challenge05

class MockMovieDetailsRepoImpl: MovieDetailsRepo {
    
    var result : Result<MovieDetailsEntity,FetchErrorType>?
    
    func fetchMovieDetails(for id: Int) async -> Result<MovieDetailsEntity,FetchErrorType> {
        
        switch result {
        case .success(let value):
            return .success(value)
        case .failure:
            return .failure(.noData)
        case .none:
            return .failure(.noNetwork)
        }
    }
}
