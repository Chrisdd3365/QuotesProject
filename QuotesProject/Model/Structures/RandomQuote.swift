//
//  RandomQuote.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 05/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct RandomQuotes: Decodable {
    let id: Int
    let title: String
    let content: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "title"
        case content = "content"
        case link = "link"
    }
}
