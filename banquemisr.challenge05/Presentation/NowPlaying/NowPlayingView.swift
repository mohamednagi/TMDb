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
    @State private var showAlert = false
    
    var movies: [ResultsEntity] {
        return vm.nowPlayingMovies
    }
    
    var body: some View {
        NavigationStack {
            if vm.state.0 == .nowPlaying {
                switch vm.state.1 {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                case .success:
                    MoviesList(movies: movies)
                case .failed(_):
                    Group {
                        if movies.isEmpty {
                            EmptyView()
                        } else {
                            MoviesList(movies: movies)
                        }
                    }
                }
            }
        }
        .task(id: didFetchMovies) {
            if !didFetchMovies {
                await vm.fetchMovies(with: .nowPlaying)
                didFetchMovies = true
                showAlert = vm.showAlert.0 && (vm.state.0 == .nowPlaying)
            }
        }
        .alert(isPresented: $showAlert) {
            return Alert(
                title: Text(vm.showAlert.1.rawValue),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

//#Preview {
//    NowPlayingView()
//}
