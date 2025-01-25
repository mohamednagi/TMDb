//
//  MovieDetailsTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import XCTest
@testable import banquemisr_challenge05

final class MovieDetailsTests: XCTestCase {
    
    var viewModel: MovieDetailsViewModelImpl!
    var mockUsecase: MockMovieDetailsUseCase!
    var movieId: Int!
    var mockDetails: MovieDetailsEntity!
    
    override func setUp() {
        super.setUp()
        mockUsecase = MockMovieDetailsUseCase()
        viewModel = MovieDetailsViewModelImpl(movieDetailsUseCase: mockUsecase)
        movieId = 1
        mockDetails = MockData.shared.getMockedMovieDetails()
    }
    
    override func tearDown() {
        mockUsecase = nil
        viewModel = nil
        movieId = nil
        mockDetails = nil
        super.tearDown()
    }
    
    func testMovieDetailsSuccess() async {
        // Given
        
        mockUsecase.movieDetails.value = mockDetails
        let expectation = expectation(description: "details should be fetched")
        
        // When
        await viewModel.fetchMovieDetails(for: movieId)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertNotNil(self.viewModel.movieDetails)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation],timeout: 2)
    }
    
    func testMovieDetailsFailure() async {
        // Given
        mockUsecase.movieDetails.value = mockDetails
        let expectation = expectation(description: "movieId should be different")
        
        // When
        await viewModel.fetchMovieDetails(for: movieId)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertTrue(self.viewModel.movieDetails?.id != self.movieId)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation],timeout: 2)
    }
}
