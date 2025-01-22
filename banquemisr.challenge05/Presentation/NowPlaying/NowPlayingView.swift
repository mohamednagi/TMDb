//
//  NowPlayingView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import SwiftUI

struct NowPlayingView: View {
    @StateObject var vm = MoviesViewModelImpl(moviesUseCase: FetchMoviesUseCaseImpl())
    @State private var didFetchMovies = false
    
    var movies: [ResultsEntity] {
        return vm.nowPlayingMovies
    }
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                NavigationLink {
                    MovieDetailsView(movie: movie.rootNode)
                } label: {
                    MovieCell(posterPath: movie.rootNode?.posterPath ?? "",
                              title: movie.rootNode?.title ?? "",
                              releaseDate: movie.rootNode?.releaseDate ?? "")
                }
            }
            .task(id: didFetchMovies) {
                if !didFetchMovies {
                    await vm.fetchMovies(with: .nowPlaying)
                    didFetchMovies = true
                }
            }
        }
    }
}

//#Preview {
//    NowPlayingView()
//}
