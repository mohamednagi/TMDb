//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation


protocol MovieDetailsViewModel {
    func fetchMovieDetails(for id: Int) async
}


class MovieDetailsViewModelImpl: MovieDetailsViewModel, ObservableObject {
    
    @Published var movieDetails = MovieDetailsEntity()
    
    private let movieDetailsUseCase: MovieDetailsUseCase
    
    init(movieDetailsUseCase: MovieDetailsUseCaseImpl) {
        self.movieDetailsUseCase = movieDetailsUseCase
        handleObservation(useCase: movieDetailsUseCase)
    }
    
    private func handleObservation(useCase: MovieDetailsUseCaseImpl) {
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
