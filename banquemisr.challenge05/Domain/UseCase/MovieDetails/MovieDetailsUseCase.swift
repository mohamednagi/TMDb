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
    private let repo: MovieDetailsRepo
    
    var movieDetails: DynamicObjects<MovieDetailsEntity> = DynamicObjects(MovieDetailsEntity())
    
    
    init(repo: MovieDetailsRepo = MovieDetailsRepoImpl()) {
        self.repo = repo
    }
    
    func fetchMovieDetails(for id: Int) async {
        let result = await repo.fetchMovieDetails(for: id)
        switch result {
        case .success(let details):
            movieDetails.value = details
        case .failure( _):
            movieDetails.value = .init()
        }
    }
}
