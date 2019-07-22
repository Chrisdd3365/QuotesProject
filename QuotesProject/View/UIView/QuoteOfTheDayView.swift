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
    var quoteOfTheDayViewConfigure: ContentsResponse? {
        didSet {
            quoteLabel.text = quoteOfTheDayViewConfigure?.contents.quotes[0].quote
            quoteLabel.layer.shadowColor = UIColor.black.cgColor
            quoteLabel.layer.shadowOpacity = 0.9
            quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
            
            authorLabel.text = quoteOfTheDayViewConfigure?.contents.quotes[0].author

            if let backgroundURL = quoteOfTheDayViewConfigure?.contents.quotes[0].background {
                backgroundImageView.sd_setImage(with: URL(string: backgroundURL))
            } 
        }
    }
}
