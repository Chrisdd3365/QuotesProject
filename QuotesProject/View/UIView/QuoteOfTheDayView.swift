//
//  QuoteOfTheDayView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 19/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import SDWebImage

class QuoteOfTheDayView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    //MARK: - Property
    var quoteOfTheDayViewConfigure: ContentsQuoteOfTheDay? {
        didSet {
            quoteLabel.text = quoteOfTheDayViewConfigure?.contents.quotes[0].quote
            quoteLabel.setupShadowLabel(label: quoteLabel)
            
            authorLabel.text = quoteOfTheDayViewConfigure?.contents.quotes[0].author
            authorLabel.setupShadowLabel(label: authorLabel)

            if let backgroundImageURL = quoteOfTheDayViewConfigure?.contents.quotes[0].background {
                backgroundImageView.sd_setImage(with: URL(string: backgroundImageURL))
            } 
        }
    }
}
