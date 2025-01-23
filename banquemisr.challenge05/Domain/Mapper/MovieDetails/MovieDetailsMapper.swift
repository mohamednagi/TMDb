//
//  MovieDetailsMapper.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation

class MovieDetailsMapper: MapperManager {
    typealias DTO = MovieDetailsBaseModel
    typealias Entity = MovieDetailsEntity
    
    func map(from dto: DTO) -> Entity {
        let rootNode = createResultsModel(from: dto)
        return Entity(rootNode: rootNode)
    }
    
    private func createResultsModel(from dto: MovieDetailsBaseModel) -> MovieDetailsModel {
        return MovieDetailsModel(id: dto.id ?? -1,
                                 adult: dto.adult ?? false,
                                 backdropPath: Endpoint.shared.getImageEndpoint() + (dto.backdrop_path ?? ""),
                                 genres: dto.genres ?? [],
                                 overview: dto.overview ?? "",
                                 posterPath: Endpoint.shared.getImageEndpoint() + (dto.poster_path ?? ""),
                                 releaseDate: dto.release_date ?? "",
                                 title: dto.title ?? "")
    }
    
}
