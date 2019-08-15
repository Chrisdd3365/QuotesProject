//
//  QuoteOfTheDayService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 12/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class QuoteOfTheDayService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var quoteOfTheDaySession: URLSession
    
    //MARK: - Initializers
    init(quoteOfTheDaySession: URLSession = URLSession(configuration: .default)) {
        self.quoteOfTheDaySession = quoteOfTheDaySession
    }
    
    //MARK: - Methods
    //TheySaidSoAPI URL
    func quoteOfTheDayURL() -> String {
        let baseURL = Constants.TheySaidSoAPI.BaseURL.baseURL
        let quoteOfTheDayURL = Constants.TheySaidSoAPI.QuoteOfTheDayURL.quoteOfTheDayURL
        
        return baseURL + quoteOfTheDayURL
    }
    
    //TheySaidSoAPI call
    func getQuoteOfTheDay(callback: @escaping (Bool, ContentsQuoteOfTheDay?) -> Void) {
        guard let url = URL(string: quoteOfTheDayURL()) else { return }
        task?.cancel()
        task = quoteOfTheDaySession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(ContentsQuoteOfTheDay.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
