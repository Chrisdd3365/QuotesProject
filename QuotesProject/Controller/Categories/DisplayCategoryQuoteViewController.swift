//
//  DisplayCategoryQuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayCategoryQuoteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var categoryQuoteView: CategoryQuoteView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Properties
    var categoryQuote: Contents?
    var imagePicker: ImagePicker?
    var favoritesQuotes = FavoriteQuote.all

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryQuoteViewSetup()
        buttonsSetImage()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesQuotes = FavoriteQuote.all
        buttonsSetImage()
    }
    
    //MARK: - Actions
    @IBAction func takePictures(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func shareQuote(_ sender: UIButton) {
        didTapShareButtonCategoryQuote(view: categoryQuoteView)
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        addToFavoritesListSetup()
    }
    
    
    //MARK: - Methods
    private func categoryQuoteViewSetup() {
        categoryQuoteView.categoryQuoteViewConfigure = self.categoryQuote
    }
    
    private func addToFavoritesListSetup() {
        guard let contents = categoryQuoteView.categoryQuoteViewConfigure else { return }
        if checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: contents.contents.id) == false {
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            CoreDataManager.saveCategoryQuoteToFavoritesQuotes(contents: contents)
            favoritesQuotes = FavoriteQuote.all
        } else {
            favoritesQuotes = FavoriteQuote.all
            showAlert(title: "Sorry!", message: "You've already added this quote into your favorite list!")
        }
    }
    
    private func buttonsSetImage() {
        guard let contentsResponse = categoryQuoteView.categoryQuoteViewConfigure else { return }
        favoriteButton.setImage(updateButtonImage(check: checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: contentsResponse.contents.id), checkedImage: "favorite", uncheckedImage: "noFavorite"), for: .normal)
    }
}

extension DisplayCategoryQuoteViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.categoryQuoteView.backgroundImageView.image = image
    }
}
