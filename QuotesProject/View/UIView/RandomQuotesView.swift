//
//  RandomQuotesView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 05/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import HTMLString

class RandomQuotesView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    //MARK: - Property
    var randomQuotesViewConfigure: RandomQuotes? {
        didSet {
            let content = randomQuotesViewConfigure?.content
            let contentHtmlTagsRemoved = content?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            let randomQuote = contentHtmlTagsRemoved?.removingHTMLEntities
            quoteLabel.text = randomQuote

            authorLabel.text = randomQuotesViewConfigure?.title
        }
    }
}
