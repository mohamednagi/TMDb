//
//  FetchMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol MoviesUseCase {
    var state: DynamicObjects<(MoviesListType,Status)> { get }
    var nowPlayingMovies: DynamicObjects<[ResultsEntity]> { get }
    var popularMovies: DynamicObjects<[ResultsEntity]> { get }
    var upComingMovies: DynamicObjects<[ResultsEntity]> { get }
    func fetchMovies(in query: MoviesListType) async
}

class MoviesUseCaseImpl: MoviesUseCase {
    private let repo: MoviesRepo
    
    var nowPlayingMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    var popularMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    var upComingMovies: DynamicObjects<[ResultsEntity]> = DynamicObjects([])
    var state: DynamicObjects<(MoviesListType,Status)> = DynamicObjects((.nowPlaying,.notStarted))
    let mapper: any MapperManager
    
    init(repo: MoviesRepo = MoviesRepoImpl(), mapper: any MapperManager = ResultsMapper()) {
        self.repo = repo
        self.mapper = mapper
    }
    
    func fetchMovies(in query: MoviesListType) async {
        state.value = (query,.fetching)
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
            nowPlayingMovies.value = map(query:query,dto: result)
        case .popular:
            popularMovies.value = map(query:query,dto: result)
        case .upcoming:
            upComingMovies.value = map(query:query,dto: result)
        }
        state.value = (query,.success)
    }
    
    private func handle(_ error: FetchErrorType, in query: MoviesListType) {
        switch query {
        case .nowPlaying:
            nowPlayingMovies.value = []
        case .popular:
            popularMovies.value = []
        case .upcoming:
            upComingMovies.value = []
        }
        state.value = (query,.failed(error: error))
    }
    
    private func map(query: MoviesListType, dto: [Results]) -> [ResultsEntity] {
        return dto.compactMap { results in
            if let entityMapper = mapper as? ResultsMapper {
                let entities = entityMapper.map(from: results)
                return entities
            }else {
                return nil
            }
        }
    }
}
