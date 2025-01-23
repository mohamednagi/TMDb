//
//  PopularView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import SwiftUI

struct PopularView: View {
    @StateObject var vm = MoviesViewModelImpl(moviesUseCase: MoviesUseCaseImpl())
    @State private var didFetchMovies = false
    
    var movies: [ResultsEntity] {
        return vm.popularMovies
    }
    
    var body: some View {
        NavigationStack {
            MoviesList(movies: movies)
            .task(id: didFetchMovies) {
                if !didFetchMovies {
                    await vm.fetchMovies(with: .popular)
                    didFetchMovies = true
                }
            }
        }
    }
}

//#Preview {
//    PopularView()
//}
