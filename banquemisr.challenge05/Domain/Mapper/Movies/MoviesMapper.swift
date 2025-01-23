//
//  MoviesMapper.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

class MoviesMapper: MapperManager {
    
    typealias DTO = MoviesBaseModel
    typealias Entity = MoviesEntity
    
    func map(from dto: DTO) -> Entity {
        let rootNode = createMoviesModel(from: dto)
        return Entity(rootNode: rootNode)
    }
    
    private func createMoviesModel(from dto: MoviesBaseModel) -> MoviesModel {
        return MoviesModel(dates: dto.dates,
                           page: dto.page,
                           results: dto.results,
                           total_pages: dto.total_pages,
                           total_results: dto.total_results)
    }
}
