//
//  QuoteOfTheDay.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 12/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct ContentsResponse: Decodable {
    let contents: Quotes
    
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
    }
}

struct Quotes: Decodable {
    let quotes: [Quote]
    
    enum CodingKeys: String, CodingKey {
        case quotes = "quotes"
    }
}

struct Quote: Decodable {
    let quote: String
    let author: String
    let category: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case author = "author"
        case category = "category"
        case title = "title"
    }
}
