//
//  QuoteOfTheDayViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 19/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class QuoteOfTheDayViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var quoteOfTheDayView: QuoteOfTheDayView!
    
    //MARK: - Properties
    let quoteOfTheDayService = QuoteOfTheDayService()
    var favoritesQuotes = FavoritesQuotes.all
    var imagePicker: ImagePicker?

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuoteOfTheDayData()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    
    //MARK: - Actions
    @IBAction func pickingPictures(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func shareQuoteOfTheDay(_ sender: UIButton) {
        didTapShareButton(quote: quoteOfTheDayView.quoteOfTheDayTextView.text ?? "", author: quoteOfTheDayView.authorLabel.text ?? "")
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        didTapFavoriteButton(quote: quoteOfTheDayView.quoteOfTheDayTextView.text ?? "", author: quoteOfTheDayView.authorLabel.text ?? "")
        favoritesQuotes = FavoritesQuotes.all
    }
    
    //MARK: - Methods
    private func fetchQuoteOfTheDayData() {
        quoteOfTheDayService.getQuoteOfTheDay { (success, contentsResponse) in
            if success {
                self.displayContents(quotes: contentsResponse?.contents.quotes ?? [])
            } else {
                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
            }
        }
    }
    
    private func displayContents(quotes: [Quote]) {
        quoteOfTheDayView.quoteOfTheDayTextView.text = quotes[0].quote
        quoteOfTheDayView.authorLabel.text = quotes[0].author
     }
}

extension QuoteOfTheDayViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.quoteOfTheDayView.backgroundImageView.image = image
    }
}
