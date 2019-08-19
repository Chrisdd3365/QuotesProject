//
//  RandomImageService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class RandomImageService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var randomImageSession: URLSession
    
    //MARK: - Initializers
    init(randomImageSession: URLSession = URLSession(configuration: .default)) {
        self.randomImageSession = randomImageSession
    }

    //MARK: - Methods
    //TheySaidSoAPI URL
    func randomImageURL() -> String {
        let baseURL = Constants.TheySaidSoAPI.BaseURL.baseURL
        let imageURL = Constants.TheySaidSoAPI.ImageQuoteURL.imageURL
        let apiKeyURL = Constants.TheySaidSoAPI.BaseURL.apiKeyURL
        let apiKey = Constants.TheySaidSoAPI.BaseURL.apiKey
        
        return baseURL + imageURL + apiKeyURL + apiKey
    }
    
    //TheySaidSoAPI call (Random Image Quote)
    func getRandomImage(callback: @escaping (Bool, ContentsImage?) -> Void) {
        guard let url = URL(string: randomImageURL()) else { return }
        task?.cancel()
        task = randomImageSession.dataTask(with: url) { data, response, error in
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
            }
        }
        task?.resume()
    }
}
