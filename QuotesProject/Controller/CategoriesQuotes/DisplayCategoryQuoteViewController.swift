//
//  DisplayCategoryQuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class DisplayCategoryQuoteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var categoryQuoteView: CategoryQuoteView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    //MARK: - Properties
    let categoryQuoteService = CategoryQuoteService()
    var categoryQuote: ContentsCategoryQuote?
    var imagePicker: ImagePicker?
    var favoritesQuotes = FavoriteQuote.all

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryQuoteViewSetup()
        buttonsSetImage()
        imagePickerDelegate()
        newQuoteButtonSetup()
        navigationItem.title = categoryQuote?.contents.requestedCategory ?? ""
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
        didTapShareButton(view: categoryQuoteView)
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        addToFavoritesListSetup()
    }
    
    @IBAction func newQuoteButtonTapped(_ sender: UIButton) {
        fetchCategoryQuoteData(category: categoryQuote?.contents.requestedCategory ?? "")
    }
    
    //MARK: - Methods
    private func imagePickerDelegate() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    
    private func categoryQuoteViewSetup() {
        categoryQuoteView.categoryQuoteViewConfigure = self.categoryQuote
    }
    
    private func newQuoteButtonSetup() {
        newQuoteButton.layer.cornerRadius = 5
    }
}

//MARK: - Fetch Data
extension DisplayCategoryQuoteViewController {
    private func fetchCategoryQuoteData(category: String) {
        activityIndicatorView.startAnimating()
        toggleActivityIndicator(shown: true, activityIndicatorView: activityIndicatorView, button: newQuoteButton)
        
        categoryQuoteService.getCategoryQuote(category: category) { (success, contents) in
            self.activityIndicatorView.stopAnimating()
            self.toggleActivityIndicator(shown: false, activityIndicatorView: self.activityIndicatorView, button: self.newQuoteButton)
            
            if success {
                self.categoryQuote = contents
                self.categoryQuoteViewSetup()
                self.buttonsSetImage()
            } else {
                self.showAlert(title: "Sorry!", message: "No quote for such category exists!")
            }
        }
    }
}

//MARK: - Favorites Setup Methods
extension DisplayCategoryQuoteViewController {
    private func addToFavoritesListSetup() {
        guard let contentsCategoryQuote = categoryQuoteView.categoryQuoteViewConfigure else { return }
        if checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: contentsCategoryQuote.contents.id) == false {
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            CoreDataManager.saveCategoryQuoteToFavoritesQuotes(contentsCategoryQuote: contentsCategoryQuote)
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
