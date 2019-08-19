//
//  CategoryImageService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class CategoryImageService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var categoryImageSession: URLSession
    
    //MARK: - Initializers
    init(categoryImageSession: URLSession = URLSession(configuration: .default)) {
        self.categoryImageSession = categoryImageSession
    }
    
    //MARK: - Methods
    //TheySaidSoAPI URL
    func categoryImageURL(category: String) -> String {
        let baseURL = Constants.TheySaidSoAPI.BaseURL.baseURL
        let imageURL = Constants.TheySaidSoAPI.ImageQuoteURL.imageURL
        let apiKeyURL = Constants.TheySaidSoAPI.BaseURL.apiKeyURL
        let apiKey = Constants.TheySaidSoAPI.BaseURL.apiKey
        let categoryURL = Constants.TheySaidSoAPI.BaseURL.categoryURL
        
        return baseURL + imageURL + apiKeyURL + apiKey + categoryURL + category
    }
    
    //TheySaidSoAPI call (Category Image Quote)
    func getCategoryImage(category: String, callback: @escaping (Bool, ContentsImage?) -> Void) {
        guard let url = URL(string: categoryImageURL(category: category)) else { return }
        task?.cancel()
        task = categoryImageSession.dataTask(with: url) { data, response, error in
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
