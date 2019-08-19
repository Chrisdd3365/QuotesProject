//
//  FakeResponseData.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    static let incorrectData = "error".data(using: .utf8)!
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class AllTypeOfError: Error {}
    static let error = AllTypeOfError()
}

class FakeQuoteOfTheDayResponseData: FakeResponseData {
    static var quoteOfTheDayCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "QuoteOfTheDayService", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

class FakeRandomQuotesResponseData: FakeResponseData {
    static var randomQuotesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RandomQuotesService", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

class FakeRandomQuoteResponseData: FakeResponseData {
    static var randomQuoteCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RandomQuoteService", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

class FakeCategoryQuoteResponseData: FakeResponseData {
    static var categoryQuoteCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CategoryQuoteService", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

class FakeRandomImageResponseData: FakeResponseData {
    static var randomImageCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RandomImageService", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

class FakeCategoryImageResponseData: FakeResponseData {
    static var categoryImageCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CategoryImageService", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}
