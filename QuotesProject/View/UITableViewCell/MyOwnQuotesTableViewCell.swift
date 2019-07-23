//
//  MyOwnQuotesTableViewCell.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 05/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class MyOwnQuotesTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    //MARK: - Property
    var myOwnQuotesCellConfigure: MyOwnQuote? {
        didSet {
            quoteLabel.text = myOwnQuotesCellConfigure?.quote
            authorLabel.text = "- " + "\(myOwnQuotesCellConfigure?.author ?? "")"
            
            if authorLabel.text == "- " {
                authorLabel.text = "- Anonymous Author"
            }
        }
    }
}
