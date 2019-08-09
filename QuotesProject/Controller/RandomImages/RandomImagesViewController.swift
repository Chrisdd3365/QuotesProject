//
//  RandomImagesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class RandomImagesViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var imageQuoteView: ImageQuoteView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newImageButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var imageQuoteService = ImageQuoteService()
    var imageQuote: ContentsImage?
    var favoritesImages = FavoriteImage.all
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageQuoteViewSetup()
        buttonsSetImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesImages = FavoriteImage.all
        buttonsSetImage()
    }
    
    //MARK: - Actions
    @IBAction func tappedNewImageButton(_ sender: UIButton) {
        fetchImageQuoteData()
    }
    
    @IBAction func tappedShareButton(_ sender: UIButton) {
        didTapShareButton(view: imageQuoteView)
    }
    
    @IBAction func tappedFavoriteButton(_ sender: UIButton) {
        addToFavoritesListSetup()
    }
    
    //MARK: - Methods
    private func fetchImageQuoteData() {
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, button: newImageButton)
        imageQuoteService.getImageQuote { (success, contentsImage) in
            self.toggleActivityIndicator(shown: false, activityIndicator: self.activityIndicator, button: self.newImageButton)
            if success {
                self.imageQuote = contentsImage
                self.imageQuoteViewSetup()
                self.buttonsSetImage()
            } else {
                self.showAlert(title: "Sorry!", message: "Image not available!")
            }
        }
    }
    
    private func imageQuoteViewSetup() {
        imageQuoteView.imageQuoteViewConfigure = self.imageQuote
    }
    
    private func addToFavoritesListSetup() {
        guard let contentsImage = imageQuoteView.imageQuoteViewConfigure else { return }
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
        guard let contentsImage = imageQuoteView.imageQuoteViewConfigure else { return }
        favoriteButton.setImage(updateButtonImage(check: checkFavoriteImage(favoritesImages: favoritesImages, id: contentsImage.contents.qimage.id), checkedImage: "like", uncheckedImage: "unlike"), for: .normal)
    }
}

