//
//  MovieDetailsEntity.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation

struct MovieDetailsEntity {
    var rootNode = MovieDetailsModel(id: -1,
                                     adult: false,
                                     backdropPath: "",
                                     genres: [],
                                     overview: "",
                                     posterPath: "",
                                     releaseDate: "",
                                     title: "")
}

struct MovieDetailsModel {
    let id : Int
    let adult : Bool
    let backdropPath : String
    let genres : [Genres]
    let overview : String
    let posterPath : String
    let releaseDate : String
    let title : String
}
