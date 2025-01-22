//
//  FetchMoviesRepo.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import Foundation

protocol FetchMoviesRepo {
    func fetchMovies(in query: MoviesListType) async -> Result<[Results],FetchErrorType>
}
