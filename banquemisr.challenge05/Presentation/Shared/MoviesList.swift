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
                MovieDetailsView(movieId: movie.rootNode.id)
            } label: {
                MovieCell(posterPath: movie.rootNode.posterPath,
                          title: movie.rootNode.title,
                          releaseDate: movie.rootNode.releaseDate)
            }
        }
    }
}

#Preview {
//    MoviesList()
}
