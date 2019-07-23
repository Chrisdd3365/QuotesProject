//
//  MyOwnQuoteView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class MyOwnQuoteView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: - Property
    var myOwnQuoteViewConfigure: MyOwnQuote? {
        didSet {
            quoteLabel.text = myOwnQuoteViewConfigure?.quote
            quoteLabel.layer.shadowColor = UIColor.black.cgColor
            quoteLabel.layer.shadowOpacity = 0.9
            quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
            
            authorLabel.text = myOwnQuoteViewConfigure?.author
            if authorLabel.text == "" {
                authorLabel.text = "- Anonymous Author"
            }
        }
    }
}
