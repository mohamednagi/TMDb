//
//  MovieDetailsEntity.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation

struct MovieDetailsEntity: Codable {
    
    let id : Int?
    let adult : Bool?
    let backdropPath : String?
    let genres : [Genres]?
    let overview : String?
    let posterPath : String?
    let releaseDate : String?
    let title : String?
    
    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case id = "id"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
    init(id: Int, adult: Bool, backdropPath: String, genres: [Genres], overview: String, posterPath: String, releaseDate: String, title: String){
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.genres = genres
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
    }
   
}
