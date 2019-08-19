//
//  RandomQuoteServiceTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import QuotesProject

class RandomQuoteServiceTests: XCTestCase {
    func testGetRandomQuoteShouldGetFailedCallbackIfError() {
        // Given
        let randomQuoteService = RandomQuoteService(
            randomQuoteSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuoteService.getRandomQuote { success, randomQuote  in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomQuoteShouldGetFailedCallbackIfNoData() {
        // Given
        let randomQuoteService = RandomQuoteService(
            randomQuoteSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuoteService.getRandomQuote { success, randomQuote in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomQuoteShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let randomQuoteService = RandomQuoteService(
            randomQuoteSession: URLSessionFake(data: FakeRandomQuoteResponseData.randomQuoteCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuoteService.getRandomQuote { success, randomQuote in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomQuoteShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let randomQuoteService = RandomQuoteService(
            randomQuoteSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuoteService.getRandomQuote { success, randomQuote in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomQuoteShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let randomQuoteService = RandomQuoteService(
            randomQuoteSession: URLSessionFake(data: FakeRandomQuoteResponseData.randomQuoteCorrectData,
                                                response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomQuoteService.getRandomQuote { success, randomQuote in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(randomQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
