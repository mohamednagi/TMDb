//
//  MapperManager.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol MapperManager {
    associatedtype DTO
    associatedtype Entity
    func map(from dto: DTO) -> Entity
}
