//
//  NowPlayingView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import SwiftUI

struct NowPlayingView: View {
    @StateObject var vm = MoviesViewModelImpl(moviesUseCase: FetchMoviesUseCaseImpl())
    
    var movies: [ResultsEntity] {
        return vm.nowPlayingMovies
    }
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                NavigationLink {
                    // navigate to details
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: "\(movie.rootNode?.posterPath ?? "")")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .shadow(color: .white, radius: 1)
                        
                        
                        VStack(alignment: .leading) {
                            Text(movie.rootNode?.title ?? "")
                                .fontWeight(.bold)
                            
                            Text(movie.rootNode?.releaseDate ?? "")
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            .task {
                await vm.fetchMovies(with: .nowPlaying)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NowPlayingView()
}
