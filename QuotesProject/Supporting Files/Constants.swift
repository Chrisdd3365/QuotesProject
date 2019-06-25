//
//  Constants.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 13/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct Constants {
    static let baseURL = "http://quotes.rest/"
    static let apiKeyURL = "?api_key="
    static let apiKey = ""
    
    struct QuotesURL {
        static let quoteOfTheDayURL = "qod.json"
        static let randomQuoteURL = "quote/random.json"
    }
    
    struct ImagesURL {
        static let randomImageURL = "quote/image/search.json"
        static let randomImageByCategoryURL = "quote/image/search.json?category="
        static let randomImageByAuthorURL = "http://quotes.rest/quote/image/search.json?author="
    }
    
    struct SeguesIdentifiers {
        static let timeIntervalSegue = "TimeIntervalSegue"
    }
}
