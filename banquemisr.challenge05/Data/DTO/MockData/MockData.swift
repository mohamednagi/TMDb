//
//  MockData.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Foundation

class MockData {
    static let shared = MockData()
    private init() {}
    
    func getMockedMovieDetails() -> MovieDetailsEntity {
        let mockMovieDetail = MovieDetailsEntity(id: -1,
                                                 adult: false,
                                                 backdropPath: "",
                                                 genres: [],
                                                 overview: "",
                                                 posterPath: "",
                                                 releaseDate: "",
                                                 title: "")
        return mockMovieDetail
    }
    
    func getMockedMoviesList() -> [ResultsEntity] {
        var moviesArray = [ResultsEntity]()
        for i in 0 ..< 5 {
            let mockedMovie = ResultsEntity(id: i,
                                            posterPath: Endpoint.shared.getImageEndpoint() + "/jbOSUAWMGzGL1L4EaUF8K6zYFo7.jpg",
                                            releaseDate: "\(Date())",
                                            title: "movie \(i)")
            moviesArray.append(mockedMovie)
        }
        return moviesArray
    }
    
    func getMockedResultsList() -> [Results] {
        var moviesArray = [Results]()
        for i in 0 ..< 5 {
            let mockedMovie = Results(id: i,
                                      title: "movie \(i)",
                                      posterPath: Endpoint.shared.getImageEndpoint() + "/jbOSUAWMGzGL1L4EaUF8K6zYFo7.jpg",
                                      releaseDate: "\(Date())"
            )
            moviesArray.append(mockedMovie)
        }
        return moviesArray
    }
}
