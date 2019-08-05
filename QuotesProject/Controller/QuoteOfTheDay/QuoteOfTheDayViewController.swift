//
//  QuoteOfTheDayViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 19/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class QuoteOfTheDayViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var quoteOfTheDayView: QuoteOfTheDayView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Properties
    let quoteOfTheDayService = QuoteOfTheDayService()
    var favoritesQuotes = FavoriteQuote.all
    var imagePicker: ImagePicker?

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuoteOfTheDayData()
        buttonsSetImage()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesQuotes = FavoriteQuote.all
        buttonsSetImage()
    }
    
    //MARK: - Actions
    @IBAction func pickingPictures(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func shareQuoteOfTheDay(_ sender: UIButton) {
        didTapShareButton(view: quoteOfTheDayView)
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        addToFavoritesListSetup()
    }
    
    //MARK: - Methods
    private func fetchQuoteOfTheDayData() {
        quoteOfTheDayService.getQuoteOfTheDay { (success, contentsResponse) in
            if success {
                self.quoteOfTheDayView.quoteOfTheDayViewConfigure = contentsResponse
            } else {
                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
            }
        }
    }
    
    private func addToFavoritesListSetup() {
        guard let contentsResponse = quoteOfTheDayView.quoteOfTheDayViewConfigure else { return }
        if checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: contentsResponse.contents.quotes[0].id) == false {
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            CoreDataManager.saveQuoteOfTheDayToFavoritesQuotes(contentsResponse: contentsResponse)
            favoritesQuotes = FavoriteQuote.all
        } else {
            favoritesQuotes = FavoriteQuote.all
            showAlert(title: "Sorry!", message: "You've already added this quote into your favorite list!")
        }
    }
    
    private func buttonsSetImage() {
        guard let contentsResponse = quoteOfTheDayView.quoteOfTheDayViewConfigure else { return }
        favoriteButton.setImage(updateButtonImage(check: checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: contentsResponse.contents.quotes[0].id), checkedImage: "favorite", uncheckedImage: "noFavorite"), for: .normal)
    }
}

extension QuoteOfTheDayViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.quoteOfTheDayView.backgroundImageView.image = image
    }
}
