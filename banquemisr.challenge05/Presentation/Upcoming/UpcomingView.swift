//
//  UpcomingView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import SwiftUI

struct UpcomingView: View {
    @StateObject var vm = MoviesViewModelImpl(moviesUseCase: FetchMoviesUseCaseImpl())
    @State private var didFetchMovies = false
    
    var movies: [ResultsEntity] {
        return vm.upComingMovies
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
                    await vm.fetchMovies(with: .upcoming)
                    didFetchMovies = true
                }
            }
        }
    }
}

//#Preview {
//    UpcomingView()
//}

