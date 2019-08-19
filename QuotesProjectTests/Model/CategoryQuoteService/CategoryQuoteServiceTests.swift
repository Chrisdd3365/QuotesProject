//
//  CategoryQuoteServiceTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import QuotesProject

class CategoryQuoteServiceTests: XCTestCase {
    let category = "love"
    
    func testGetCategoryQuoteShouldGetFailedCallbackIfError() {
        // Given
        let categoryQuoteService = CategoryQuoteService(
            categoryQuoteSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryQuoteService.getCategoryQuote(category: category) { success, categoryQuote  in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
 
    func testGetCategoryQuoteShouldGetFailedCallbackIfNoData() {
        // Given
        let categoryQuoteService = CategoryQuoteService(
            categoryQuoteSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryQuoteService.getCategoryQuote(category: category) { success, categoryQuote in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCategoryQuoteShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let categoryQuoteService = CategoryQuoteService(
            categoryQuoteSession: URLSessionFake(data: FakeCategoryQuoteResponseData.categoryQuoteCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryQuoteService.getCategoryQuote(category: category) { success, categoryQuote in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCategoryQuoteShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let categoryQuoteService = CategoryQuoteService(
            categoryQuoteSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryQuoteService.getCategoryQuote(category: category) { success, categoryQuote in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCategoryQuoteShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let categoryQuoteService = CategoryQuoteService(
            categoryQuoteSession: URLSessionFake(data: FakeCategoryQuoteResponseData.categoryQuoteCorrectData,
                                               response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryQuoteService.getCategoryQuote(category: category) { success, categoryQuote in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(categoryQuote)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
