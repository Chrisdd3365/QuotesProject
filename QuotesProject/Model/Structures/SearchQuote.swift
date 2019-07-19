//
//  SearchQuote.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 12/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct ContentsSearchQuoteResponse: Decodable {
    let contents: SearchQuote

    enum CodingKeys: String, CodingKey {
        case contents = "contents"
    }
}

struct SearchQuote: Decodable {
    let quote: String
    let author: String
    let id: String
    let requestedCategory: String
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case author = "author"
        case id = "id"
        case requestedCategory = "requested_category"
    }
}
