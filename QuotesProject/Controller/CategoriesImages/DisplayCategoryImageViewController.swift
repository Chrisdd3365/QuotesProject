//
//  DisplayCategoryImageViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayCategoryImageViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var displayCategoryImageView: DisplayCategoryImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newImageButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    private func fetchCategoryImageData(category: String) {
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, button: newImageButton)
        
        imageQuoteService.getCategoryImageQuote(category: category) { (success, contentsImage) in
            self.toggleActivityIndicator(shown: false, activityIndicator: self.activityIndicator, button: self.newImageButton)
            if success {
                self.categoryImage = contentsImage
                self.displayCategoryImageViewSetup()
                self.buttonsSetImage()
            } else {
                self.showAlert(title: "Sorry!", message: "No image for such category exists!")
            }
        }
    }
    
    private func displayCategoryImageViewSetup() {
        displayCategoryImageView.categoryImageViewConfigure = self.categoryImage
    }
    
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
