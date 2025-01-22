//
//  ResultsEntity.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

struct ResultsEntity: Identifiable {
    var rootNode: ResultsModel? = nil
    var id = UUID()
}

struct ResultsModel {
    let adult : Bool
    let backdropPath : String
    let genreIds : [Int]
    let id : Int
    let originalLanguage : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterPath : String
    let releaseDate : String
    let title : String
    let video : Bool
    let voteAverage : Double
    let voteCount : Int
}
