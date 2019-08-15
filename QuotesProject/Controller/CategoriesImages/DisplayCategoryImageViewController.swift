//
//  DisplayCategoryImageViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class DisplayCategoryImageViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var displayCategoryImageView: DisplayCategoryImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newImageButton: UIButton!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    //MARK: - Properties
    let imageQuoteService = ImageQuoteService()
    var categoryImage: ContentsImage?
    var favoritesImages = FavoriteImage.all
    var categoryLabel: String?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCategoryImageViewSetup()
        buttonsSetImage()
        navigationItem.title = categoryLabel ?? "" 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesImages = FavoriteImage.all
        buttonsSetImage()
    }
    
    //MARK: - Actions
    @IBAction func shareImage(_ sender: UIButton) {
        didTapShareButton(view: displayCategoryImageView)
    }
    
    @IBAction func didTapNewImageButon(_ sender: UIButton) {
        fetchCategoryImageData(category: categoryLabel ?? "")
    }
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        addToFavoritesListSetup()
    }
    
    //MARK: - Methods
    private func displayCategoryImageViewSetup() {
        displayCategoryImageView.categoryImageViewConfigure = self.categoryImage
    }
}

//MARK: - Fetch Data
extension DisplayCategoryImageViewController {
    private func fetchCategoryImageData(category: String) {
        activityIndicatorView.startAnimating()
        toggleActivityIndicator(shown: true, activityIndicatorView: activityIndicatorView, button: newImageButton)
        
        imageQuoteService.getCategoryImageQuote(category: category) { (success, contentsImage) in
            self.activityIndicatorView.stopAnimating()
            self.toggleActivityIndicator(shown: false, activityIndicatorView: self.activityIndicatorView, button: self.newImageButton)
            
            if success {
                self.categoryImage = contentsImage
                self.displayCategoryImageViewSetup()
                self.buttonsSetImage()
            } else {
                self.showAlert(title: "Sorry!", message: "No image for such category exists!")
            }
        }
    }
}

//MARK: - Favorites Setup Methods
extension DisplayCategoryImageViewController {
    private func addToFavoritesListSetup() {
        guard let contentsImage = displayCategoryImageView.categoryImageViewConfigure else { return }
        if checkFavoriteImage(favoritesImages: favoritesImages, id: contentsImage.contents.qimage.id) == false {
            favoriteButton.setImage(UIImage(named: "like"), for: .normal)
            CoreDataManager.saveFavoriteImage(contentsImage: contentsImage)
            favoritesImages = FavoriteImage.all
        } else {
            favoritesImages = FavoriteImage.all
            showAlert(title: "Sorry!", message: "You've already added this image into your favorite list!")
        }
    }
    
    private func buttonsSetImage() {
        guard let contentsImage = displayCategoryImageView.categoryImageViewConfigure else { return }
        favoriteButton.setImage(updateButtonImage(check: checkFavoriteImage(favoritesImages: favoritesImages, id: contentsImage.contents.qimage.id), checkedImage: "like", uncheckedImage: "unlike"), for: .normal)
    }
}
