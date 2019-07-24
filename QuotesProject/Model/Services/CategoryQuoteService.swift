//
//  CategoryQuoteService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class CategoryQuoteService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var categoryQuoteSession: URLSession
    
    //MARK: - Initializers
    init(categoryQuoteSession: URLSession = URLSession(configuration: .default)) {
        self.categoryQuoteSession = categoryQuoteSession
    }
    
    //MARK: - Methods
    //URL method
    func categoryQuoteURL(category: String) -> String {
        let baseURL = Constants.TheySaidSoAPI.BaseURL.baseURL
        let searchURL = Constants.TheySaidSoAPI.CategoryQuoteURL.searchURL
        let categoryURL = Constants.TheySaidSoAPI.CategoryQuoteURL.categoryURL + category
        let apiKeyURL = Constants.TheySaidSoAPI.BaseURL.apiKeyURL
        let apiKey = Constants.TheySaidSoAPI.BaseURL.apiKey
        
        return baseURL + searchURL + categoryURL + apiKeyURL + apiKey
    }
    
    //API method
    func getCategoryQuote(category: String, callback: @escaping (Bool, Contents?) -> Void) {
        guard let url = URL(string: categoryQuoteURL(category: category)) else { return }
        task?.cancel()
        task = categoryQuoteSession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Contents.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
                print(responseJSON)
            }
        }
        task?.resume()
    }
}
