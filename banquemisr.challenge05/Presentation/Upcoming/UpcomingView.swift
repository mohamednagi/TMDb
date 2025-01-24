//
//  UpcomingView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import SwiftUI

struct UpcomingView: View {
    @StateObject var vm = MoviesViewModelImpl(moviesUseCase: MoviesUseCaseImpl())
    @State private var didFetchMovies = false
    @State private var showAlert = false
    
    var movies: [ResultsEntity] {
        return vm.upComingMovies
    }
    
    var body: some View {
        NavigationStack {
            if vm.state.0 == .upcoming {
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
                await vm.fetchMovies(with: .upcoming)
                didFetchMovies = true
                showAlert = vm.showAlert.0 && (vm.state.0 == .upcoming)
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
//    UpcomingView()
//}

