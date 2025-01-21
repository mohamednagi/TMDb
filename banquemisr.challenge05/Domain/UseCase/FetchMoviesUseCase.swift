//
//  FetchMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol FetchMoviesUseCaseProtocol {
    func FetchMovies(in query: MoviesListType) async
}

class FetchMoviesUseCaseImpl: FetchMoviesUseCaseProtocol {
    private let repo: FetchMoviesRepo
    
    init(repo: FetchMoviesRepo = FetchMoviesRepoImpl()) {
        self.repo = repo
    }
    
    func FetchMovies(in query: MoviesListType) async {
        do {
            
        } catch {
            fatalError("should be handled soon")
        }
    }
}
