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
    
    var nowPlayingMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    var popularMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    var upComingMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    
    let mapper: any MapperManager
    
    init(repo: FetchMoviesRepo = FetchMoviesRepoImpl(), mapper: any MapperManager = ResultsMapper()) {
        self.repo = repo
        self.mapper = mapper
    }
    
    func fetchMovies(in query: MoviesListType) async {
        switch query {
        case .nowPlaying:
            let result = await repo.fetchMovies(in: .nowPlaying)
            switch result {
            case .success(let movies):
                handle(movies, in: query)
            case .failure(let error):
                handle(error, in: query)
            }
        case .popular:
            let result = await repo.fetchMovies(in: .popular)
            switch result {
            case .success(let movies):
                handle(movies, in: query)
            case .failure(let error):
                handle(error, in: query)
            }
        case .upcoming:
            let result = await repo.fetchMovies(in: .upcoming)
            switch result {
            case .success(let movies):
                handle(movies, in: query)
            case .failure(let error):
                handle(error, in: query)
            }
        }
    }
    
    private func handle(_ result: [Results], in query: MoviesListType) {
        switch query {
        case .nowPlaying:
            nowPlayingMovies.value = map(dto: result)
        case .popular:
            popularMovies.value = map(dto: result)
        case .upcoming:
            upComingMovies.value = map(dto: result)
        }
    }
    
    private func handle(_ error: FetchErrorType, in query: MoviesListType) {
        switch error {
        case .noData:
            switch query {
            case .nowPlaying:
                nowPlayingMovies.value = []
            case .popular:
                popularMovies.value = []
            case .upcoming:
                upComingMovies.value = []
            }
        default: break
        }
    }
    
    private func map(dto: [Results]) -> [ResultsEntity] {
        return dto.compactMap { results in
            if let entityMapper = mapper as? ResultsMapper {
                return entityMapper.map(from: results)
            }else {
                return nil
            }
        }
    }
}
