//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import SwiftUI


protocol MovieDetailsViewModel {
    func fetchMovieDetails(for id: Int) async
}


class MovieDetailsViewModelImpl: MovieDetailsViewModel, ObservableObject {
    
    @Published var movieDetails: MovieDetailsEntity?
    @Published var state: Status = .notStarted
    @Published var showAlert = (false,FetchErrorType.noData)
    
    private let movieDetailsUseCase: MovieDetailsUseCase
    
    init(movieDetailsUseCase: MovieDetailsUseCase) {
        self.movieDetailsUseCase = movieDetailsUseCase
        handleObservation(useCase: movieDetailsUseCase)
    }
    
    private func handleObservation(useCase: MovieDetailsUseCase) {
        useCase.state.bind { state in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {return}
                self.state = state
                switch state {
                case .failed(let error):
                    showAlert = (true,error)
                default:
                    showAlert = (false,.noData)
                }
            }
        }
        useCase.movieDetails.bind { details in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {return}
                self.movieDetails = details
            }
        }
    }
    
    func fetchMovieDetails(for id: Int) async {
        await movieDetailsUseCase.fetchMovieDetails(for: id)
    }
}
