//
//  ImagesService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 14/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class ImagesService {
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var imageSession: URLSession
    
    //MARK: - Initializers
    init(imageSession: URLSession = URLSession(configuration: .default)) {
        self.imageSession = imageSession
    }
    
    
    
    
}
