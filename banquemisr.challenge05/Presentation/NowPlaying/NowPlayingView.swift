//
//  NowPlayingView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import SwiftUI

struct NowPlayingView: View {
    @StateObject var vm = MoviesViewModelImpl(moviesUseCase: MoviesUseCaseImpl())
    @State private var didFetchMovies = false
    
    var movies: [ResultsEntity] {
        return vm.nowPlayingMovies
    }
    
    var body: some View {
        NavigationStack {
            MoviesList(movies: movies)
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
