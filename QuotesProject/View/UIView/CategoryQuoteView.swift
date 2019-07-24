//
//  CategoryQuoteView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class CategoryQuoteView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - Property
    var categoryQuoteViewConfigure: Contents? {
        didSet {
            quoteLabel.text = categoryQuoteViewConfigure?.contents.quote
            quoteLabel.layer.shadowColor = UIColor.black.cgColor
            quoteLabel.layer.shadowOpacity = 0.9
            quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
            
            authorLabel.text = categoryQuoteViewConfigure?.contents.author
        }
    }
    
}
