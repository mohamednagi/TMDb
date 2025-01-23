//
//  MoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol MoviesViewModel {
    func fetchMovies(with query: MoviesListType) async
}


class MoviesViewModelImpl: MoviesViewModel, ObservableObject {
    
    @Published var nowPlayingMovies = [ResultsEntity]()
    @Published var popularMovies = [ResultsEntity]()
    @Published var upComingMovies = [ResultsEntity]()
    
    private let moviesUseCase: MoviesUseCase
    
    init(moviesUseCase: MoviesUseCaseImpl) {
        self.moviesUseCase = moviesUseCase
        handleObservation(useCase: moviesUseCase)
    }
    
    private func handleObservation(useCase: MoviesUseCaseImpl) {
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
