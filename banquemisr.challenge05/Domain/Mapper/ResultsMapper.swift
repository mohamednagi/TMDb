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
        return ResultsModel(adult: dto.adult,
                            backdrop_path: dto.backdrop_path,
                            genre_ids: dto.genre_ids,
                            id: dto.id,
                            original_language: dto.original_language,
                            original_title: dto.original_title,
                            overview: dto.overview,
                            popularity: dto.popularity,
                            poster_path: dto.poster_path,
                            release_date: dto.release_date,
                            title: dto.title,
                            video: dto.video,
                            vote_average: dto.vote_average,
                            vote_count: dto.vote_count)
    }
}
