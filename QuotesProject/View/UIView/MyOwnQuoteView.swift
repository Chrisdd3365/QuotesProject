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
    var myOwnQuoteViewConfigure: MyOwnQuotes? {
        didSet {
            quoteLabel.text = myOwnQuoteViewConfigure?.quote
            
            authorLabel.text = "- " + "\(myOwnQuoteViewConfigure?.author ?? "")"
            if authorLabel.text == "- " {
                authorLabel.text = "- Anonymous Author"
            }
        }
    }
}
