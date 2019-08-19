//
//  RandomImagesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RandomImagesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var imageQuoteView: ImageQuoteView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newImageButton: UIButton!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    //MARK: - Properties
    var randomImageService = RandomImageService()
    var imageQuote: ContentsImage?
    var favoritesImages = FavoriteImage.all
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageQuoteViewSetup()
        buttonsSetImage()
        setupButton(button: newImageButton)
        navigationItem.title = "Random Images"
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
    private func imageQuoteViewSetup() {
        imageQuoteView.imageQuoteViewConfigure = self.imageQuote
    }
}

//MARK: - Fetch Data
extension RandomImagesViewController {
    private func fetchImageQuoteData() {
        activityIndicatorView.startAnimating()
        toggleActivityIndicator(shown: true, activityIndicatorView: activityIndicatorView, button: newImageButton)
        
        randomImageService.getRandomImage { (success, contentsImage) in
            self.activityIndicatorView.stopAnimating()
            self.toggleActivityIndicator(shown: false, activityIndicatorView: self.activityIndicatorView, button: self.newImageButton)
            
            if success {
                self.imageQuote = contentsImage
                self.imageQuoteViewSetup()
                self.buttonsSetImage()
            } else {
                self.showAlert(title: "Sorry!", message: "Image not available!")
            }
        }
    }
}

//MARK: - Favorite Setup Methods
extension RandomImagesViewController {
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
