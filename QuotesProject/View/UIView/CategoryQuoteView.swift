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
    var categoryQuoteViewConfigure: ContentsCategoryQuote? {
        didSet {
            quoteLabel.text = categoryQuoteViewConfigure?.contents.quote
            quoteLabel.setupShadowLabel(label: quoteLabel)
            
            authorLabel.text = categoryQuoteViewConfigure?.contents.author
            authorLabel.setupShadowLabel(label: authorLabel)
        }
    }
}
