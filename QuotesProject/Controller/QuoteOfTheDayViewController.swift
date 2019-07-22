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
        didTapShareButton(view: quoteOfTheDayView)
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        didTapFavoriteButton(quote: quoteOfTheDayView.quoteLabel.text ?? "", author: quoteOfTheDayView.authorLabel.text ?? "")
        favoritesQuotes = FavoritesQuotes.all
    }
    
    //MARK: - Methods
    private func fetchQuoteOfTheDayData() {
        //toggleActivityIndicator(shown: true)
        quoteOfTheDayService.getQuoteOfTheDay { (success, contentsResponse) in
            //self.toggleActivityIndicator(shown: false)
            if success {
                self.quoteOfTheDayView.quoteOfTheDayViewConfigure = contentsResponse
            } else {
                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
            }
        }
    }

//    private func toggleActivityIndicator(shown: Bool) {
//        quoteOfTheDayView.activityIndicator.isHidden = !shown
//    }
}

extension QuoteOfTheDayViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.quoteOfTheDayView.backgroundImageView.image = image
    }
}
