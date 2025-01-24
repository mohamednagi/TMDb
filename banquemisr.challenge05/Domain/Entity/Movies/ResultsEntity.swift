//
//  ResultsEntity.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

struct ResultsEntity: Identifiable {
    var rootNode = ResultsModel(id: -1,
                                posterPath: "",
                                releaseDate: "",
                                title: "")
    var id = UUID()
}

struct ResultsModel {
    let id : Int
    let posterPath : String
    let releaseDate : String
    let title : String
}
