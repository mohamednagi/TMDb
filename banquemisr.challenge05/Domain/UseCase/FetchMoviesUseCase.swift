//
//  FetchMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol FetchMoviesUseCaseProtocol {
    func fetchMovies(in query: MoviesListType) async
}

class FetchMoviesUseCaseImpl: FetchMoviesUseCaseProtocol {
    private let repo: FetchMoviesRepo
    
    var nowPlayingMovies: DynamicObjects<[MoviesBaseModel]> = DynamicObjects([])
    var popularMovies: DynamicObjects<[MoviesBaseModel]> = DynamicObjects([])
    var upComingMovies: DynamicObjects<[MoviesBaseModel]> = DynamicObjects([])
    
    init(repo: FetchMoviesRepo = FetchMoviesRepoImpl()) {
        self.repo = repo
    }
    
    func fetchMovies(in query: MoviesListType) async {
        do {
            switch query {
            case .nowPlaying:
                nowPlayingMovies.value = try await repo.fetchMovies(in: .nowPlaying)
            case .popular:
                popularMovies.value = try await repo.fetchMovies(in: .popular)
            case .upcoming:
                upComingMovies.value = try await repo.fetchMovies(in: .upcoming)
            }
        } catch {
            fatalError("should be handled soon")
        }
    }
}
