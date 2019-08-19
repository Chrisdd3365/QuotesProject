//
//  RandomImageServiceTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import QuotesProject

class RandomImageServiceTests: XCTestCase {
    func testGetRandomImageShouldGetFailedCallbackIfError() {
        // Given
        let randomImageService = RandomImageService(
            randomImageSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomImageService.getRandomImage { success, randomImage  in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRandomImageShouldGetFailedCallbackIfNoData() {
        // Given
        let randomImageService = RandomImageService(
            randomImageSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomImageService.getRandomImage { success, randomImage in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomImageShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let randomImageService = RandomImageService(
            randomImageSession: URLSessionFake(data: FakeRandomImageResponseData.randomImageCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomImageService.getRandomImage { success, randomImage in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomImageShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let randomImageService = RandomImageService(
            randomImageSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomImageService.getRandomImage { success, randomImage in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(randomImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRandomImageShouldGetSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let randomImageService = RandomImageService(
            randomImageSession: URLSessionFake(data: FakeRandomImageResponseData.randomImageCorrectData,
                                               response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        randomImageService.getRandomImage { success, randomImage in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(randomImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
