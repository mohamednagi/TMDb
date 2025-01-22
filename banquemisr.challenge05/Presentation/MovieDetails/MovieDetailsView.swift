//
//  MovieDetails.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    
    var movie: ResultsModel?
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: URL(string: movie?.backdropPath ?? "")) { image in
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
                    
                    AsyncImage(url: URL(string: movie?.posterPath ?? "")) { image in
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
                    Text(movie?.title ?? "")
                        .font(.largeTitle)
                    
                    Text("Is it for adults only?")
                        .font(.title2)
                        .padding(.top, 15)
                        .padding(.bottom, 5)
                    
                    Text("\(movie?.adult ?? false ? "Yes" : "No")")
                    
                    
                    Text("Genre IDs")
                        .font(.title2)
                        .padding(.top, 15)
                        .padding(.bottom, 5)
                    
                    ForEach(movie?.genreIds ?? [], id: \.self) { id in
                        Text("•" + "\(id)")
                            .font(.subheadline)
                    }
                    
                    Text("Overview")
                        .font(.title2)
                        .padding(.vertical)
                    
                    Text(movie?.overview ?? "")
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)
            }
            
        }
        .ignoresSafeArea()
        .toolbarBackground(.hidden)
        .toolbar(.hidden, for: .tabBar)
    }
}

//#Preview {
//    MovieDetailsView(movie: ResultsModel(adult: false, backdropPath: "", genreIds: [], id: 0, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "", video: false, voteAverage: 0, voteCount: 0))
//}
