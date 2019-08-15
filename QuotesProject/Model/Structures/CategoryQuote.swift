//
//  CategoryQuote.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct ContentsCategoryQuote: Decodable {
    let contents: CategoryQuote
    
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
    }
}

struct CategoryQuote: Decodable {
    let quote: String
    let author: String?
    let id: String
    let requestedCategory: String?
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case author = "author"
        case id = "id"
        case requestedCategory = "requested_category"
    }
}


