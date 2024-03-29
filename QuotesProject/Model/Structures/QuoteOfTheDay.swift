//
//  QuoteOfTheDay.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 12/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct ContentsQuoteOfTheDay: Decodable {
    let contents: Quotes
    
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
    }
}

struct Quotes: Decodable {
    let quotes: [QuoteOfTheDay]
    
    enum CodingKeys: String, CodingKey {
        case quotes = "quotes"
    }
}

struct QuoteOfTheDay: Decodable {
    let quote: String
    let author: String?
    let category: String
    let title: String
    let background: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case author = "author"
        case category = "category"
        case title = "title"
        case background = "background"
        case id = "id"
    }
}
