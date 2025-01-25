//
//  MovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation

protocol MovieDetailsUseCase {
    var state: DynamicObjects<Status> { get }
    var movieDetails: DynamicObjects<MovieDetailsEntity> { get }
    func fetchMovieDetails(for id: Int) async
}

class MovieDetailsUseCaseImpl: MovieDetailsUseCase {
    
    private let repo: MovieDetailsRepo
    var state: DynamicObjects<Status> = DynamicObjects(.notStarted)
    var movieDetails: DynamicObjects<MovieDetailsEntity> = DynamicObjects(MockData.shared.getMockedMovieDetails())
    
    
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
            if let details = UserDefaultsManager.shared.get(MovieDetailsEntity.self, forKey: .movieDetails(id)) {
                movieDetails.value = details
                state.value = .success
            }else {
                movieDetails.value = MockData.shared.getMockedMovieDetails()
                state.value = .failed(error: error)
            }
            
        }
    }
}
