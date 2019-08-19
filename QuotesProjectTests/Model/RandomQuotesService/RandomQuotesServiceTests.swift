//
//  RandomQuotesServiceTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import QuotesProject

class RandomQuotesServiceTests: XCTestCase {
    func testGetRandomQuotesShouldGetFailedCallbackIfError() {
        // Given
        let randomQuotesService = RandomQuotesService(
            randomQuotesSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuotesService.getRandomQuotes { success, randomQuotes  in
            // Then
            XCTAssertFalse(success)
            XCTAssertNotNil(randomQuotes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomQuotesShouldGetFailedCallbackIfNoData() {
        // Given
        let randomQuotesService = RandomQuotesService(
            randomQuotesSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuotesService.getRandomQuotes { success, randomQuotes in
            // Then
            XCTAssertFalse(success)
            XCTAssertNotNil(randomQuotes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRandomQuotesShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let randomQuotesService = RandomQuotesService(
            randomQuotesSession: URLSessionFake(data: FakeRandomQuotesResponseData.randomQuotesCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuotesService.getRandomQuotes { success, randomQuotes in
            // Then
            XCTAssertFalse(success)
            XCTAssertNotNil(randomQuotes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomQuotesShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let randomQuotesService = RandomQuotesService(
            randomQuotesSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuotesService.getRandomQuotes { success, randomQuotes in
            // Then
            XCTAssertFalse(success)
            XCTAssertNotNil(randomQuotes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomQuotesShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let randomQuotesService = RandomQuotesService(
            randomQuotesSession: URLSessionFake(data: FakeRandomQuotesResponseData.randomQuotesCorrectData,
                                                response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuotesService.getRandomQuotes { success, randomQuotes in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(randomQuotes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
