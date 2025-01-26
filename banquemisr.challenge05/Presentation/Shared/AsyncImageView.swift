//
//  AsyncImageView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 26/01/2025.
//

import SwiftUI

import SwiftUI

struct AsyncImageView: View {
    let imageURL: URL?
    @State private var uiImage: UIImage? = nil
    @State private var isLoading = false

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else if isLoading {
                ProgressView() // Show a loading spinner while the image is loading
            } else {
                Color.gray // Placeholder or fallback view
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard uiImage == nil else { return } // Avoid reloading if already loaded
        guard let imgURL = imageURL else {return}
        isLoading = true
        
        let request = URLRequest(url: imgURL)

        // Check cache first
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            self.uiImage = image
            self.isLoading = false
            return
        }

        // If not cached, download the image
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                // Cache the image
                if let response = response {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    URLCache.shared.storeCachedResponse(cachedData, for: request)
                }

                DispatchQueue.main.async {
                    self.uiImage = image
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}


//#Preview {
//    AsyncImageView()
//}
