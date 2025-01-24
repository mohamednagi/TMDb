//
//  MovieCell.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 22/01/2025.
//

import SwiftUI

struct MovieCell: View {
    
    var posterPath,title,releaseDate: String
    
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: posterPath)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .shadow(color: .white, radius: 1)
            
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(releaseDate)
                    .fontWeight(.regular)
            }
        }
    }
}

#Preview {
    MovieCell(posterPath: "https://image.tmdb.org/t/p/w500/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg",
              title: "test",
              releaseDate: "22-1-2025")
}
