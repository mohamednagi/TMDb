//
//  MoviesList.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import SwiftUI

struct MoviesList: View {
    var movies: [ResultsEntity]
    
    var body: some View {
        List(movies) { movie in
            NavigationLink {
                MovieDetailsView(movieId: movie.id)
            } label: {
                MovieCell(posterPath: movie.posterPath,
                          title: movie.title,
                          releaseDate: movie.releaseDate)
            }
        }
    }
}

#Preview {
    MoviesList(movies: MockData.shared.getMockedMoviesList())
}
