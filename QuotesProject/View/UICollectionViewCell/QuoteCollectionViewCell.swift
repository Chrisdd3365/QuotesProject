//
//  QuoteCollectionViewCell.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 18/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    
    //MARK: - Property
    var quoteCollectionViewCellConfigure: Quote? {
        didSet {
            quoteTextView.text = quoteCollectionViewCellConfigure?.quote
            authorLabel.text = quoteCollectionViewCellConfigure?.author
        }
    }
}
