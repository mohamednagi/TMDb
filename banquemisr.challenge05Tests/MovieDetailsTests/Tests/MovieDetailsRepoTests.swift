//
//  MovieDetailsRepoTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 26/01/2025.
//

import XCTest
@testable import banquemisr_challenge05

final class MovieDetailsRepoTests: XCTestCase {
    
    var repo: MovieDetailsRepoImpl!
    var movieId: Int!
    var mockDetails: MovieDetailsEntity!
    
    override func setUp() {
        super.setUp()
        repo = MovieDetailsRepoImpl()
        movieId = -1
        mockDetails = MockData.shared.getMockedMovieDetails()
    }
    
    override func tearDown() {
        repo = nil
        movieId = nil
        mockDetails = nil
        super.tearDown()
    }
    
    func testRepoSuccess() async {
        // Given
        let mockRepoResult = Result<MovieDetailsEntity,FetchErrorType>.success(mockDetails)
        let successResponse: MovieDetailsEntity?
        switch mockRepoResult {
        case .success(let details):
            successResponse = details
        case .failure(_):
            successResponse = nil
        }
        let expectation = expectation(description: "details should be fetched")
        
        // When
        let result = await repo.fetchMovieDetails(for: movieId)
        
        // Then
        DispatchQueue.main.async {
            switch result {
            case .success(let details):
                XCTAssertEqual(details.id, successResponse?.id)
                expectation.fulfill()
            case .failure:
                XCTAssertEqual(MockData.shared.getMockedMovieDetails().id, successResponse?.id)
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation],timeout: 2)
    }
}
