//
//  FavoriteQuoteView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 23/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoriteQuoteView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    //MARK: - Property
    var favoriteQuoteViewConfigure: FavoriteQuote? {
        didSet {
            quoteLabel.text = favoriteQuoteViewConfigure?.quote
            quoteLabel.layer.shadowColor = UIColor.black.cgColor
            quoteLabel.layer.shadowOpacity = 0.9
            quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
            
            authorLabel.text = favoriteQuoteViewConfigure?.author
            if authorLabel.text == "" {
                authorLabel.text = "- Anonymous Author"
            }
            
            if let backgroundImageURL = favoriteQuoteViewConfigure?.backgroundImageURL {
                backgroundImageView.sd_setImage(with: URL(string: backgroundImageURL))
            }
        }
    }
}
