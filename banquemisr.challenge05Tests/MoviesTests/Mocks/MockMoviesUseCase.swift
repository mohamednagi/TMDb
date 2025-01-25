//
//  MockMoviesUseCase.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Foundation
@testable import banquemisr_challenge05

class MockMoviesUseCase: MoviesUseCase {
    func map(query: MoviesListType, dto: [Results]) -> [ResultsEntity] {
        return result
    }
    
    var state: DynamicObjects<(MoviesListType, Status)> = DynamicObjects((.nowPlaying,.success))
    
    var nowPlayingMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    
    var popularMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    
    var upComingMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    
    var result: [ResultsEntity] = []
    
    
    func fetchMovies(in query: MoviesListType) async {
        switch query {
        case .nowPlaying:
            result = nowPlayingMovies.value
        case .popular:
            result = popularMovies.value
        case .upcoming:
            result = upComingMovies.value
        }
    }
}
