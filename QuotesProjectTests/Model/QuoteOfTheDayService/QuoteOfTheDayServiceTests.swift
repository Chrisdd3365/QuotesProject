//
//  QuoteOfTheDayServiceTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import QuotesProject

class QuoteOfTheDayServiceTests: XCTestCase {
    func testGetQuoteOfTheDayShouldGetFailedCallbackIfError() {
        // Given
        let quoteOfTheDayService = QuoteOfTheDayService(
            quoteOfTheDaySession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        quoteOfTheDayService.getQuoteOfTheDay { success, quoteOfTheDay  in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(quoteOfTheDay)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteOfTheDayShouldGetFailedCallbackIfNoData() {
        // Given
        let quoteOfTheDayService = QuoteOfTheDayService(
            quoteOfTheDaySession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        quoteOfTheDayService.getQuoteOfTheDay { success, quoteOfTheDay in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(quoteOfTheDay)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteOfTheDayShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let quoteOfTheDayService = QuoteOfTheDayService(
            quoteOfTheDaySession: URLSessionFake(data: FakeQuoteOfTheDayResponseData.quoteOfTheDayCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        quoteOfTheDayService.getQuoteOfTheDay { success, quoteOfTheDay in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(quoteOfTheDay)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testQuoteOfTheDayShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let quoteOfTheDayService = QuoteOfTheDayService(
            quoteOfTheDaySession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        quoteOfTheDayService.getQuoteOfTheDay { success, quoteOfTheDay in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(quoteOfTheDay)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteOfTheDayShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let quoteOfTheDayService = QuoteOfTheDayService(
            quoteOfTheDaySession: URLSessionFake(data: FakeQuoteOfTheDayResponseData.quoteOfTheDayCorrectData,
                response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        quoteOfTheDayService.getQuoteOfTheDay { success, quoteOfTheDay in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(quoteOfTheDay)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
