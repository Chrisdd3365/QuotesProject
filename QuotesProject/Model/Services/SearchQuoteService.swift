//
//  SearchQuoteService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 12/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

//class SearchQuoteService {
//    //MARK: - Properties
//    var task: URLSessionDataTask?
//    private var searchQuoteSession: URLSession
//    
//    //MARK: - Initializers
//    init(searchQuoteSession: URLSession = URLSession(configuration: .default)) {
//        self.searchQuoteSession = searchQuoteSession
//    }
//    
//    //MARK: - Methods
//    //URL method
//    func searchQuoteURL(category: String) -> String {
//        let baseURL = Constants.baseURL
//        let searchURL = Constants.SearchURL.searchURL
//        let apiKeyURL = Constants.apiKeyURL
//        let apiKey = Constants.apiKey
//        let minlengthURL = Constants.SearchURL.minlengthURL
//        let minlength = "100"
//        let maxlengthURL = Constants.SearchURL.maxlengtURL
//        let maxlength = "300"
//        let categoryURL = Constants.SearchURL.categoryURL
//        let category = category
//        
//        return baseURL + searchURL + apiKeyURL + apiKey + minlengthURL + minlength + maxlengthURL + maxlength +
//        categoryURL + category
//    }
//    
//    //API method
//    func getSearchQuote(category: String, callback: @escaping (Bool, ContentsSearchQuoteResponse?) -> Void) {
//        guard let url = URL(string: searchQuoteURL(category: category)) else { return }
//        task?.cancel()
//        task = searchQuoteSession.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                guard let data = data, error == nil else {
//                    callback(false, nil)
//                    return
//                }
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    callback(false, nil)
//                    return
//                }
//                guard let responseJSON = try? JSONDecoder().decode(ContentsSearchQuoteResponse.self, from: data) else {
//                    callback(false, nil)
//                    return
//                }
//                callback(true, responseJSON)
//            }
//        }
//        task?.resume()
//    }
//}
