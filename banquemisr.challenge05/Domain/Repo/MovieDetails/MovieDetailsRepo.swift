//
//  MovieDetailsRepo.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 23/01/2025.
//

import Foundation

protocol MovieDetailsRepo {
    func fetchMovieDetails(for id: Int) async -> Result<MovieDetailsEntity,FetchErrorType>
}
