//
//  CategoryImage.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

struct ContentsImage: Decodable {
    let contents: Qimage
    
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
    }
}

struct Qimage: Decodable {
    let qimage: Image
    
    enum CodingKeys: String, CodingKey {
        case qimage = "qimage"
    }
}

struct Image: Decodable {
    let id: String
    let quoteId: String
    let downloadUri: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case quoteId = "quote_id"
        case downloadUri = "download_uri"
    }
}
