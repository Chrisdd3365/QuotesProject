//
//  QuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet var quotesView: QuotesView!
    
    //MARK: - Properties
    let quotesService = QuotesService()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuoteData()
    }
    
    //MARK: - Methods
    private func displayContents(quote: [Quote]) {
        quotesView.quoteTextView.text = quote[0].quote
        quotesView.authorLabel.text = quote[0].author
    }
    
    private func fetchQuoteData() {
        quotesService.getQuote { (success, contentsResponse) in
            if success {
                self.displayContents(quote: contentsResponse?.contents.quotes ?? [])
            } else {
                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
            }
        }
    }
}
