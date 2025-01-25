//
//  MovieDetailsUseCaseTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 25/01/2025.
//

import XCTest
@testable import banquemisr_challenge05

final class MovieDetailsUseCaseTests: XCTestCase {

    var mockRepo: MockMovieDetailsRepoImpl!
    var useCase: MovieDetailsUseCaseImpl!
    var movieId: Int!
    var mockDetails: MovieDetailsEntity!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockMovieDetailsRepoImpl()
        useCase = MovieDetailsUseCaseImpl(repo: mockRepo)
        movieId = 1
        mockDetails = MockData.shared.getMockedMovieDetails()
    }

    override func tearDown() {
        mockRepo = nil
        useCase = nil
        movieId = nil
        mockDetails = nil
        super.tearDown()
    }

    func testDetailsSuccess() async {
        // Given
        let repoResult = Result<MovieDetailsEntity, FetchErrorType>.success(mockDetails)
        switch repoResult {
        case .success(let details):
            mockRepo.result = .success(details)
        case .failure(_):
            mockRepo.result = .failure(.noData)
        }
        let expectation = expectation(description: "details should be fetched")
        
        
        // When
        await useCase.fetchMovieDetails(for: movieId)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertTrue(self.useCase.state.value == Status.success, "status should be success")
            expectation.fulfill()
        }
        await fulfillment(of: [expectation],timeout: 2)
    }
    
    func testDetailsFailure() async {
        // Given
        let repoResult = Result<MovieDetailsEntity, FetchErrorType>.failure(.noData)
        switch repoResult {
        case .success(let details):
            mockRepo.result = .success(details)
        case .failure(_):
            mockRepo.result = .failure(.noData)
        }
        let expectation = expectation(description: "details should be fetched")
        
        
        // When
        await useCase.fetchMovieDetails(for: movieId)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertTrue(self.useCase.state.value == Status.failed(error: .noData), "status should be failed")
            expectation.fulfill()
        }
        await fulfillment(of: [expectation],timeout: 2)
    }
}
