//
//  MovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation

protocol MovieDetailsUseCase {
    func fetchMovieDetails(for id: Int) async
}

class MovieDetailsUseCaseImpl: MovieDetailsUseCase {
    
    enum Status {
        case notStarted
        case fetching
        case success
        case failed(error: FetchErrorType)
    }
    
    
    private let repo: MovieDetailsRepo
    var state: DynamicObjects<Status> = DynamicObjects(.notStarted)
    var movieDetails: DynamicObjects<MovieDetailsEntity> = DynamicObjects(MovieDetailsEntity())
    
    
    init(repo: MovieDetailsRepo = MovieDetailsRepoImpl()) {
        self.repo = repo
    }
    
    func fetchMovieDetails(for id: Int) async {
        state.value = .fetching
        let result = await repo.fetchMovieDetails(for: id)
        switch result {
        case .success(let details):
            movieDetails.value = details
            state.value = .success
        case .failure(let error):
            movieDetails.value = .init()
            state.value = .failed(error: error)
        }
    }
}
