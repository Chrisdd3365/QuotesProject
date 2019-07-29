//
//  Constants.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 13/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct Constants {
    struct TheySaidSoAPI {
        struct BaseURL {
            static let baseURL = "http://quotes.rest/"
            static let apiKeyURL = "&api_key="
            static let apiKey = "CxkSS12F9mpQP234kwCv7AeF"
        }
        struct CategoryQuoteURL {
            static let searchURL = "quote/search.json?"
            static let categoryURL = "category="
        }
        
        struct QuoteOfTheDayURL {
            static let quoteOfTheDayURL = "qod.json"
        }
        
        struct ImageQuoteURL {
            static let imageURL = "quote/image/search.json?"
        }
    }
    
    struct QuotesOnDesignAPI {
        
    }
    
    struct SeguesIdentifiers {
        static let timeIntervalSegue = "TimeIntervalSegue"
        static let displayCategoryQuoteSegue = "DisplayCategoryQuoteSegue"
        static let displayFavoriteImageSegue = "DisplayFavoriteImageSegue"
        static let displayFavoriteQuoteSegue = "DisplayFavoriteQuoteSegue"
        static let displayMyOwnQuoteSegue = "DisplayMyOwnQuoteSegue"
    }
}
