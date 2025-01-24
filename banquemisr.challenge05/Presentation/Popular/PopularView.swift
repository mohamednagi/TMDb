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
    @State private var showAlert = false
    
    var movies: [ResultsEntity] {
        return vm.popularMovies
    }
    
    var body: some View {
        NavigationStack {
            if vm.state.0 == .popular {
                switch vm.state.1 {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                case .success:
                    MoviesList(movies: movies)
                case .failed(_):
                    EmptyView()
                }
            }
        }
        .task(id: didFetchMovies) {
            if !didFetchMovies {
                await vm.fetchMovies(with: .popular)
                didFetchMovies = true
                showAlert = vm.showAlert.0 && (vm.state.0 == .popular)
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
//    PopularView()
//}
