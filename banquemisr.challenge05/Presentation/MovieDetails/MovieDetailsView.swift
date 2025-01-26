//
//  MovieDetails.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var vm = MovieDetailsViewModelImpl(movieDetailsUseCase: MovieDetailsUseCaseImpl())
    
    var movieId: Int
    var movieDetails: MovieDetailsEntity? {
        UserDefaultsManager.shared.set(vm.movieDetails, forKey: .movieDetails(movieId))
        return vm.movieDetails
    }
    
    var body: some View {
        GeometryReader { geo in
            switch vm.state {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
            case .success:
                ScrollView {
                    ZStack(alignment: .topTrailing) {
                        
                        AsyncImageView(imageURL: URL(string: movieDetails?.backdropPath ?? ""))
                        AsyncImageView(imageURL: URL(string: movieDetails?.posterPath ?? ""))
                            .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                            .offset(y: 20)
                            .scaleEffect(x: -1)
                            .shadow(color: .black ,radius: 7)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movieDetails?.title ?? "")
                            .font(.largeTitle)
                        
                        Text("Is it for adults only?")
                            .font(.title2)
                            .padding(.top, 15)
                            .padding(.bottom, 5)
                        
                        Text("\(movieDetails?.adult ?? false ? "Yes" : "No")")
                        
                        
                        Text("Genre IDs")
                            .font(.title2)
                            .padding(.top, 15)
                            .padding(.bottom, 5)
                        
                        ForEach(movieDetails?.genres ?? [], id: \.self) { genre in
                            Text("•" + "\(genre.name ?? "")")
                                .font(.subheadline)
                        }
                        
                        Text("Overview")
                            .font(.title2)
                            .padding(.vertical)
                        
                        Text(movieDetails?.overview ?? "")
                    }
                    .padding()
                    .frame(width: geo.size.width, alignment: .leading)
                }
            case .failed(_):
                EmptyView()
            }
            
            
        }
        .ignoresSafeArea()
        .toolbarBackground(.hidden)
        .toolbar(.hidden, for: .tabBar)
        
        .task {
            await vm.fetchMovieDetails(for: movieId)
        }
        
        .alert(isPresented: $vm.showAlert.0) {
          return Alert(
            title: Text(vm.showAlert.1.rawValue),
            dismissButton: .default(Text("OK"))
          )
        }
    }
}

#Preview {
    MovieDetailsView(vm: MovieDetailsViewModelImpl(movieDetailsUseCase: MovieDetailsUseCaseImpl()), movieId: 993710)
}
