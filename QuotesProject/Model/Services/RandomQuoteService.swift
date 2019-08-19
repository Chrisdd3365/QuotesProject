//
//  RandomQuoteService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class RandomQuoteService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var randomQuoteSession: URLSession
    
    //MARK: - Initializers
    init(randomQuoteSession: URLSession = URLSession(configuration: .default)) {
        self.randomQuoteSession = randomQuoteSession
    }
    
    //MARK: - TheySaidSoAPI Methods
    //TheySaidSoAPI URL
    func randomQuoteURL() -> String {
        let baseURL = Constants.TheySaidSoAPI.BaseURL.baseURL
        let randomQuoteURL = Constants.TheySaidSoAPI.RandomQuoteURL.randomQuoteURL
        let apiKeyURL = Constants.TheySaidSoAPI.BaseURL.apiKeyURL
        let apiKey = Constants.TheySaidSoAPI.BaseURL.apiKey
        
        return baseURL + randomQuoteURL + apiKeyURL + apiKey
    }
    
    //TheySaidSoAPI call
    func getRandomQuote(callback: @escaping (Bool, ContentsCategoryQuote?) -> Void) {
        guard let url = URL(string: randomQuoteURL()) else { return }
        task?.cancel()
        task = randomQuoteSession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(ContentsCategoryQuote.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
