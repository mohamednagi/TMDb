//
//  MoviesUseCaseTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Nagi on 25/01/2025.
//

import XCTest
@testable import banquemisr_challenge05

final class MoviesUseCaseTests: XCTestCase {

    
    var mockRepo: MockMoviesRepoImpl!
    var useCase: MoviesUseCaseImpl!
    var mapper: (any MapperManager)!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockMoviesRepoImpl()
        mapper = MoviesMapper()
        useCase = MoviesUseCaseImpl(repo: mockRepo, mapper: mapper)
    }

    override func tearDown() {
        mockRepo = nil
        useCase = nil
        mapper = nil
        super.tearDown()
    }
    
    func testGetMoviesSuccess() async {
        // Given
        let mockedList = MockData.shared.getMockedResultsList()
        let repoResult = Result<[Results], FetchErrorType>.success(mockedList)
        switch repoResult {
        case .success(let list):
            mockRepo.result = .success(list)
        case .failure(_):
            mockRepo.result = .failure(.noData)
        }
        
        let expectation = expectation(description: "list should be fulfilled")
        
        // When
        await useCase.fetchMovies(in: .nowPlaying)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertTrue(self.useCase.state.value.1 == Status.success, "status should be success")
            expectation.fulfill()
        }
        await fulfillment(of: [expectation],timeout: 2)
    }
    
    func testGetMoviesFailure() async {
        // Given
        let repoResult = Result<[Results], FetchErrorType>.failure(.noData)
        switch repoResult {
        case .success(let list):
            mockRepo.result = .success(list)
        case .failure(_):
            mockRepo.result = .failure(.noData)
        }
        
        let expectation = expectation(description: "list should be failed")
        
        // When
        await useCase.fetchMovies(in: .nowPlaying)
        
        // Then
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            XCTAssertTrue(self.useCase.state.value.1 == Status.failed(error: .noData), "status should be failed")
            expectation.fulfill()
        }
        await fulfillment(of: [expectation],timeout: 2)
    }

}
