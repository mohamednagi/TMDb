//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import SwiftUI


protocol MovieDetailsViewModel {
    func fetchMovieDetails(for id: Int) async
    func getErrorMsg(for error: FetchErrorType) -> String
}


class MovieDetailsViewModelImpl: MovieDetailsViewModel, ObservableObject {
    
    @Published var movieDetails = MovieDetailsEntity()
    @Published var state: MovieDetailsUseCaseImpl.Status = .notStarted
    @Published var showAlert = (false,FetchErrorType.noData)
    
    private let movieDetailsUseCase: MovieDetailsUseCase
    
    init(movieDetailsUseCase: MovieDetailsUseCaseImpl) {
        self.movieDetailsUseCase = movieDetailsUseCase
        handleObservation(useCase: movieDetailsUseCase)
    }
    
    private func handleObservation(useCase: MovieDetailsUseCaseImpl) {
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
    
    func getErrorMsg(for error: FetchErrorType) -> String {
        var errorMsg = ""
        switch error {
        case .badResponse:
            errorMsg = "Bad response from server"
        case .badURL:
            errorMsg = "Bad URL"
        case .noData:
            errorMsg = "No data returned"
        case .noNetwork:
            errorMsg = "No network connection"
        }
        return errorMsg
    }
    
}
