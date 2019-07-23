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
    static let apiKeyURL = "api_key="
    static let apiKey = "CxkSS12F9mpQP234kwCv7AeF"

    struct SearchURL {
        static let searchURL = "quote/search?"
        static let minlengthURL = "&minlength="
        static let maxlengtURL = "&maxlengt="
        static let categoryURL = "&category="
        static let authorURL = "&author="
    }
    
    struct QuoteOfTheDayURL {
        static let quoteOfTheDayURL = "qod.json"
        //static let randomQuoteURL = "quote/random.json"
    }
    
    struct ImagesURL {
        static let randomImageURL = "quote/image/search.json"
        static let randomImageByCategoryURL = "quote/image/search.json?category="
        static let randomImageByAuthorURL = "http://quotes.rest/quote/image/search.json?author="
    }
    
    struct SeguesIdentifiers {
        static let timeIntervalSegue = "TimeIntervalSegue"
        static let displayFavoriteQuoteSegue = "DisplayFavoriteQuoteSegue"
        static let displayMyOwnQuoteSegue = "DisplayMyOwnQuoteSegue"
    }
}
