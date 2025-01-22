//
//  ResultsMapper.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

class ResultsMapper: MapperManager {
    
    typealias DTO = Results
    typealias Entity = ResultsEntity
    
    func map(from dto: DTO) -> Entity {
        let rootNode = createResultsModel(from: dto)
        return Entity(rootNode: rootNode)
    }
    
    private func createResultsModel(from dto: Results) -> ResultsModel {
        return ResultsModel(adult: dto.adult ?? false,
                            backdropPath: Endpoint.shared.getImageEndpoint() + (dto.backdrop_path ?? ""),
                            genreIds: dto.genre_ids ?? [],
                            id: dto.id ?? -1,
                            originalLanguage: dto.original_language ?? "",
                            originalTitle: dto.original_title ?? "",
                            overview: dto.overview ?? "",
                            popularity: dto.popularity ?? 0,
                            posterPath: Endpoint.shared.getImageEndpoint() + (dto.poster_path ?? ""),
                            releaseDate: dto.release_date ?? "",
                            title: dto.title ?? "",
                            video: dto.video ?? false,
                            voteAverage: dto.vote_average ?? 0,
                            voteCount: dto.vote_count ?? 0)
    }
}
