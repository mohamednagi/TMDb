//
//  FetchMoviesImpl.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

class MoviesRepoImpl: MoviesRepo {
    
    
    private let network: Network
    private let mapper: any MapperManager
    
    init(network: Network = NetworkImpl(), mapper: any MapperManager = MoviesMapper()) {
        self.network = network
        self.mapper = mapper
    }
    
    
    func fetchMovies(in query: MoviesListType) async -> Result<[Results],FetchErrorType> {
        let result = await network.fetchMovies(in: query)
        switch result {
        case .success(let value):
            let results = map(dto: value).rootNode?.results ?? []
            switch query {
            case .nowPlaying:
                UserDefaultsManager.shared.set(results, forKey: .nowPlaying)
            case .popular:
                UserDefaultsManager.shared.set(results, forKey: .popular)
            case .upcoming:
                UserDefaultsManager.shared.set(results, forKey: .upcoming)
            }
            return .success(results)
        case .failure(let error):
            switch error {
            case .noNetwork:
                return cacheResult(for: query)
            default:
                return .failure(error)
            }
            
        }
    }
    
    private func cacheResult(for query: MoviesListType) -> Result<[Results],FetchErrorType> {
        switch query {
        case .nowPlaying:
            if let results = UserDefaultsManager.shared.getArray(Results.self,
                                                                 forKey: .nowPlaying) {
                return .success(results)
            }else {
                return .failure(.noNetwork)
            }
        case .popular:
            if let results = UserDefaultsManager.shared.getArray(Results.self,
                                                                 forKey: .popular) {
                return .success(results)
            }else {
                return .failure(.noNetwork)
            }
        case .upcoming:
            if let results = UserDefaultsManager.shared.getArray(Results.self,
                                                                 forKey: .upcoming) {
                return .success(results)
            }else {
                return .failure(.noNetwork)
            }
        }
    }
    
    private func map(dto: MoviesBaseModel) -> MoviesEntity {
        if let entityMapper = mapper as? MoviesMapper {
            return entityMapper.map(from: dto)
        }
        return MoviesEntity()
    }
    
    
}
