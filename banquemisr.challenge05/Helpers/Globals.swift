//
//  Globals.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

enum MoviesListType: String {
    case nowPlaying = "now_playing"
    case popular
    case upcoming
}

enum FetchErrorType: Error {
    case badURL
    case badResponse
    case noData
}
