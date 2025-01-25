//
//  MoviesTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import XCTest
@testable import banquemisr_challenge05

final class MoviesTests: XCTestCase {

    var viewModel: MoviesViewModel!
    var mockUseCase: MockMoviesUseCase!
    var mockMovies: [ResultsEntity]!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockMoviesUseCase()
        viewModel = MoviesViewModelImpl(moviesUseCase: mockUseCase)
        mockMovies = MockData.shared.getMockedMoviesList()
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        mockMovies = nil
        super.tearDown()
    }
    
    func testMoviesSuccessResponse() async {
        // Given
        mockUseCase.nowPlayingMovies.value = mockMovies
        let expectation = expectation(description: "nowPlaying should be fetched")
        
        // When
        await viewModel.fetchMovies(with: mockUseCase.state.value.0)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertTrue(!self.viewModel.nowPlayingMovies.isEmpty, "nowPlaying should not be empty")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation],timeout: 2)
    }
    
    func testMoviesFailureResponse() async {
        // Given
        mockUseCase.nowPlayingMovies.value = []
        let expectation = expectation(description: "nowPlaying should be fetched")
        
        // When
        await viewModel.fetchMovies(with: .nowPlaying)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertTrue(self.viewModel.nowPlayingMovies.isEmpty, "nowPlaying should be empty")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation],timeout: 2)
    }

}
