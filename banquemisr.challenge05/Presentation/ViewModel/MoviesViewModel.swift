//
//  MoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol MoviesViewModelProtocol {
    func fetchMovies(with query: MoviesListType) async
}

@Observable
class MoviesViewModelImpl: MoviesViewModelProtocol {
    
    var nowPlayingMovies = [MoviesBaseModel]()
    var popularMovies = [MoviesBaseModel]()
    var upComingMovies = [MoviesBaseModel]()
    
    private let moviesUseCase: FetchMoviesUseCaseProtocol
    
    init(moviesUseCase: FetchMoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
    }
    
    private func handleObservation(useCase: FetchMoviesUseCaseImpl) {
        useCase.nowPlayingMovies.bind { movies in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {return}
                self.nowPlayingMovies = movies
            }
        }
        
        useCase.popularMovies.bind { movies in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {return}
                self.popularMovies = movies
            }
        }
        
        useCase.upComingMovies.bind { movies in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {return}
                self.upComingMovies = movies
            }
        }
    }
    
    func fetchMovies(with query: MoviesListType) async {
        await moviesUseCase.fetchMovies(in: query)
    }
    
}
