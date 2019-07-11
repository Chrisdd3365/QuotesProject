//
//  DisplayMyOwnQuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayMyOwnQuoteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var displayMyOwnQuoteView: DisplayMyOwnQuoteView!
    
    //MARK: - Properties
    var myOwnQuoteSelected: MyOwnQuotes?
    var favoriteQuote: FavoritesQuotes?

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMyOwnQuoteViewConfigure(myOwnQuoteSelected: myOwnQuoteSelected)
        displayFavoriteQuoteConfigure(favoriteQuote: favoriteQuote)
    }
    
    //MARK: - Actions
    //TO DO
    @IBAction func shareMyOwnQuote(_ sender: UIButton) {
//        didTapShareButton(myOwnQuote: myOwnQuoteSelected?.quote ?? "", author: myOwnQuoteSelected?.author ?? "")
//        didTapShareButton2(favoriteQuote: favoriteQuote?.quote ?? "", author: favoriteQuote?.author ?? "")
    }
    
    //MARK: - Methods
    private func displayMyOwnQuoteViewConfigure(myOwnQuoteSelected: MyOwnQuotes?) {
        displayMyOwnQuoteView.myOwnQuoteTextView.text = myOwnQuoteSelected?.quote
        displayMyOwnQuoteView.authorLabel.text = "- " + "\(myOwnQuoteSelected?.author ?? "")"
        
        authorLabelConfigure()
    }
    
    private func displayFavoriteQuoteConfigure(favoriteQuote: FavoritesQuotes?) {
        displayMyOwnQuoteView.myOwnQuoteTextView.text = favoriteQuote?.quote
        displayMyOwnQuoteView.authorLabel.text = "- " + "\(favoriteQuote?.author ?? "")"
        
        authorLabelConfigure()
    }
    //HELPER
    private func authorLabelConfigure() {
        if displayMyOwnQuoteView.authorLabel.text == "- " {
            displayMyOwnQuoteView.authorLabel.text = "- Anonymous Author"
        }
    }
}
