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
        return ResultsModel(id: dto.id ?? -1,
                            posterPath: Endpoint.shared.getImageEndpoint() + (dto.poster_path ?? ""),
                            releaseDate: dto.release_date ?? "",
                            title: dto.title ?? "")
    }
}
