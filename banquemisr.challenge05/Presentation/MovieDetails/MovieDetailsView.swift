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
    var movieDetails: MovieDetailsEntity {
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
                        AsyncImage(url: URL(string: movieDetails.rootNode.backdropPath)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                        
                        AsyncImage(url: URL(string: movieDetails.rootNode.posterPath)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                            .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                            .offset(y: 20)
                            .scaleEffect(x: -1)
                            .shadow(color: .black ,radius: 7)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movieDetails.rootNode.title)
                            .font(.largeTitle)
                        
                        Text("Is it for adults only?")
                            .font(.title2)
                            .padding(.top, 15)
                            .padding(.bottom, 5)
                        
                        Text("\(movieDetails.rootNode.adult ? "Yes" : "No")")
                        
                        
                        Text("Genre IDs")
                            .font(.title2)
                            .padding(.top, 15)
                            .padding(.bottom, 5)
                        
                        ForEach(movieDetails.rootNode.genres, id: \.self) { genre in
                            Text("•" + "\(genre.name ?? "")")
                                .font(.subheadline)
                        }
                        
                        Text("Overview")
                            .font(.title2)
                            .padding(.vertical)
                        
                        Text(movieDetails.rootNode.overview)
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

//#Preview {
//    MovieDetailsView(vm: MovieDetailsViewModelImpl(movieDetailsUseCase: MovieDetailsUseCaseImpl()), movieId: 993710)
//}
