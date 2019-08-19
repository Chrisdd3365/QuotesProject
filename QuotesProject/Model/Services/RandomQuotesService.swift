//
//  RandomQuotesService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 05/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class RandomQuotesService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var randomQuotesSession: URLSession
    
    //MARK: - Initializers
    init(randomQuotesSession: URLSession = URLSession(configuration: .default)) {
        self.randomQuotesSession = randomQuotesSession
    }

    //MARK: - QuotesOnDesignAPI Methods
    //QuotesOnDesignAPI URL
    func randomQuotesURL() -> String {
        let baseURL = Constants.QuotesOnDesignAPI.baseURL
        let filterOrderURL = Constants.QuotesOnDesignAPI.filterOrderURL
        let filterPostsURL = Constants.QuotesOnDesignAPI.filterPostsURL
        
        return baseURL + filterOrderURL + filterPostsURL
    }

    //QuotesOnDesignAPI call
    func getRandomQuotes(callback: @escaping (Bool, [RandomQuotes]) -> Void) {
        guard let url = URL(string: randomQuotesURL()) else { return }
        task?.cancel()
        task = randomQuotesSession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, [])
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, [])
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode([RandomQuotes].self, from: data) else {
                    callback(false, [])
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
