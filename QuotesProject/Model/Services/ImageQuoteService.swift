//
//  ImageQuoteService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class ImageQuoteService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var categoryQuoteSession: URLSession
    
    //MARK: - Initializers
    init(categoryQuoteSession: URLSession = URLSession(configuration: .default)) {
        self.categoryQuoteSession = categoryQuoteSession
    }

    //MARK: - Methods
    //URL method
    func imageQuoteURL() -> String {
        let baseURL = Constants.TheySaidSoAPI.BaseURL.baseURL
        let imageURL = Constants.TheySaidSoAPI.ImageQuoteURL.imageURL
        let apiKeyURL = Constants.TheySaidSoAPI.BaseURL.apiKeyURL
        let apiKey = Constants.TheySaidSoAPI.BaseURL.apiKey
        
        return baseURL + imageURL + apiKeyURL + apiKey
    }
    
    //API method
    func getImageQuote(callback: @escaping (Bool, ContentsImage?) -> Void) {
        guard let url = URL(string: imageQuoteURL()) else { return }
        print(url)
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
                guard let responseJSON = try? JSONDecoder().decode(ContentsImage.self, from: data) else {
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
