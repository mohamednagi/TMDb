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

enum FetchErrorType: String, Error {
    case badURL = "Bad URL"
    case badResponse = "Bad response from server"
    case noData = "No data found"
    case noNetwork = "No network connection"
}

enum Status: Equatable {
    case notStarted
    case fetching
    case success
    case failed(error: FetchErrorType)
}

enum NetworkStatus: String {
    case connected
    case disconnected
}
