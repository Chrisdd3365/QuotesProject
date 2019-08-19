//
//  CategoryImageServiceTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import QuotesProject

class CategoryImageServiceTests: XCTestCase {
    let category = "love"
    
    func testGetCategoryImageShouldGetFailedCallbackIfError() {
        // Given
        let categoryImageService = CategoryImageService(
            categoryImageSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryImageService.getCategoryImage(category: category) { success, categoryImage  in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCategoryImageShouldGetFailedCallbackIfNoData() {
        // Given
        let categoryImageService = CategoryImageService(
            categoryImageSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryImageService.getCategoryImage(category: category) { success, categoryImage in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCategoryImageShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let categoryImageService = CategoryImageService(
            categoryImageSession: URLSessionFake(data: FakeCategoryImageResponseData.categoryImageCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryImageService.getCategoryImage(category: category) { success, categoryImage in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCategoryImageShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let categoryImageService = CategoryImageService(
            categoryImageSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryImageService.getCategoryImage(category: category) { success, categoryImage in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(categoryImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCategoryImageShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let categoryImageService = CategoryImageService(
            categoryImageSession: URLSessionFake(data: FakeCategoryImageResponseData.categoryImageCorrectData,
                                                 response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        categoryImageService.getCategoryImage(category: category) { success, categoryImage in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(categoryImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
