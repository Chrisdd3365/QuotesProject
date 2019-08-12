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
            static let categoryURL = "&category="
        }
        
        struct RandomQuoteURL {
            static let randomQuoteURL = "quote/random.json?"
        }
        
        struct CategoryQuoteURL {
            static let searchURL = "quote/search.json?"
        }
        
        struct QuoteOfTheDayURL {
            static let quoteOfTheDayURL = "qod.json"
        }
        
        struct ImageQuoteURL {
            static let imageURL = "quote/image/search.json?"
        }
    }
    
    struct QuotesOnDesignAPI {
        static let baseURL = "https://quotesondesign.com/wp-json/posts?"
        static let filterOrderURL = "filter[orderby]=rand"
        static let filterPostsURL = "&filter[posts_per_page]=5"
    }
    
    struct SeguesIdentifiers {
        static let timeIntervalSegue = "TimeIntervalSegue"
        static let displayCategoryQuoteSegue = "DisplayCategoryQuoteSegue"
        static let displayCategoryImageSegue = "DisplayCategoryImageSegue"
        static let reminderSegue = "ReminderSegue"
        static let displayFavoriteImageSegue = "DisplayFavoriteImageSegue"
        static let displayFavoriteQuoteSegue = "DisplayFavoriteQuoteSegue"
        static let displayMyOwnQuoteSegue = "DisplayMyOwnQuoteSegue"
    }
}
