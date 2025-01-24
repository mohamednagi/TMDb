//
//  MovieDetailsRepoImpl.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation


class MovieDetailsRepoImpl: MovieDetailsRepo {
    
    
    private let network: Network
    private let mapper: any MapperManager
    
    init(network: Network = NetworkImpl(), mapper: any MapperManager = MovieDetailsMapper()) {
        self.network = network
        self.mapper = mapper
    }
    
    
    func fetchMovieDetails(for id: Int) async -> Result<MovieDetailsEntity,FetchErrorType> {
        let result = await network.fetchMovieDetails(with: id)
        switch result {
        case .success(let value):
            let detailsEntity = map(dto: value)
            UserDefaultsManager.shared.set(detailsEntity, forKey: .movieDetails(id))
            return .success(detailsEntity)
        case .failure(let error):
            if let details = UserDefaultsManager.shared.get(MovieDetailsEntity.self, forKey: .movieDetails(id)) {
                return .success(details)
            }else {
                return .failure(error)
            }
        }
    }
    
    private func map(dto: MovieDetailsBaseModel) -> MovieDetailsEntity {
        if let entityMapper = mapper as? MovieDetailsMapper {
            return entityMapper.map(from: dto)
        }
        return mockMovieDetail
    }
    
    
}
