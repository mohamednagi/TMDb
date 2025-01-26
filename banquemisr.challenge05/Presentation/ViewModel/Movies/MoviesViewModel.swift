//
//  MoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol MoviesViewModel {
    var nowPlayingMovies: [ResultsEntity] {get}
    var popularMovies: [ResultsEntity] {get}
    var upComingMovies: [ResultsEntity] {get}
    
    func fetchMovies(with query: MoviesListType) async
}


class MoviesViewModelImpl: MoviesViewModel, ObservableObject {
    
    @Published var nowPlayingMovies = [ResultsEntity]()
    @Published var popularMovies = [ResultsEntity]()
    @Published var upComingMovies = [ResultsEntity]()
    @Published var state: (MoviesListType,Status) = (.nowPlaying,.notStarted)
    @Published var showAlert = (false,FetchErrorType.noData)
    
    private let moviesUseCase: MoviesUseCase
    
    init(moviesUseCase: MoviesUseCase) {
        self.moviesUseCase = moviesUseCase
        handleObservation(useCase: moviesUseCase)
    }
    
    private func handleObservation(useCase: MoviesUseCase) {
        useCase.state.bind { state in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {return}
                self.state = state
                switch state.1 {
                case .failed(let error):
                    showAlert = (true,error)
                default:
                    showAlert = (false,.noData)
                }
            }
        }
        
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
