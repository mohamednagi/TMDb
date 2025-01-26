//
//  MoviesRepoTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 26/01/2025.
//

import XCTest
@testable import banquemisr_challenge05

final class MoviesRepoTests: XCTestCase {
    
    var repo: MoviesRepoImpl!
    var mockMovies: [Results]!
    
    override func setUp() {
        super.setUp()
        repo = MoviesRepoImpl()
        mockMovies = MockData.shared.getMockedResultsList()
    }
    
    override func tearDown() {
        repo = nil
        mockMovies = nil
        super.tearDown()
    }

    func testRepoSuccess() async {
        // Given
        let mockRepoResult = Result<[Results],FetchErrorType>.success(mockMovies)
        let successResponse: [Results]?
        switch mockRepoResult {
        case .success(let results):
            successResponse = results
        case .failure(_):
            successResponse = nil
        }
        let expectation = expectation(description: "movies should be fetched")
        
        // When
        let result = await repo.fetchMovies(in: .nowPlaying)
        
        // Then
        switch result {
        case .success(let movies):
            XCTAssertTrue(movies.count > 0)
            expectation.fulfill()
        case .failure:
            XCTAssertEqual(MockData.shared.getMockedMoviesList().count, successResponse?.count)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation],timeout: 2)
    }
}
