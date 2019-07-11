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
    var favoritesQuotesCellConfigure: FavoritesQuotes? {
        didSet {
            quoteLabel.text = favoritesQuotesCellConfigure?.quote
            authorLabel.text = "- " + "\(favoritesQuotesCellConfigure?.author ?? "")"
            
            if authorLabel.text == "- " {
                authorLabel.text = "- Anonymous Author"
            }
        }
    }
}
