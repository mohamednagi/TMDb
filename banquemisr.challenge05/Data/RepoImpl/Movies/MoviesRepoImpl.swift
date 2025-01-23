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
            return .success(map(dto: value).rootNode?.results ?? [])
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func map(dto: MoviesBaseModel) -> MoviesEntity {
        if let entityMapper = mapper as? MoviesMapper {
            return entityMapper.map(from: dto)
        }
        return MoviesEntity()
    }
    
    
}
