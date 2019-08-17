//
//  FavoritesQuotesTableViewCell.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoritesQuotesTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    //MARK: - Property
    var favoritesQuotesCellConfigure: FavoriteQuote? {
        didSet {
            let content = favoritesQuotesCellConfigure?.quote
            let contentHtmlTagsRemoved = content?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            let favoriteQuoteLabel = contentHtmlTagsRemoved?.removingHTMLEntities
            quoteLabel.text = favoriteQuoteLabel
   
            authorLabel.text = favoritesQuotesCellConfigure?.author ?? ""
        }
    }
}
