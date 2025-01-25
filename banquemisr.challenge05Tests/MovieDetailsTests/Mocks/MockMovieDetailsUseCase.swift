//
//  MockMovieDetailsUseCase.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Foundation
@testable import banquemisr_challenge05

class MockMovieDetailsUseCase: MovieDetailsUseCase {
    var state: DynamicObjects<Status> = DynamicObjects(.notStarted)
    var movieDetails: DynamicObjects<MovieDetailsEntity> = DynamicObjects(MockData.shared.getMockedMovieDetails())
    
    func fetchMovieDetails(for id: Int) async {
        movieDetails.value = MockData.shared.getMockedMovieDetails()
    }
    
    
}
