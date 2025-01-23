//
//  MoviesEntity.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

struct MoviesEntity {
    var rootNode: MoviesModel? = nil
}

struct MoviesModel {
    let dates : Dates?
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?
}
