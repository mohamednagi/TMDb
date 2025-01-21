//
//  DatesMapper.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

class DatesMapper: MapperManager {
    
    typealias DTO = Dates
    typealias Entity = DatesEntity
    
    func map(from dto: DTO) -> Entity {
        let rootNode = createDatesModel(from: dto)
        return Entity(rootNode: rootNode)
    }
    
    private func createDatesModel(from dto: Dates) -> DatesModel {
        return DatesModel(maximum: dto.maximum,
                          minimum: dto.minimum)
    }
}
