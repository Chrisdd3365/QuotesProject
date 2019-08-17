//
//  UIViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 13/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    //MARK: - Methods
    //Alert
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //Activity Indicator
    func toggleActivityIndicator(shown: Bool, activityIndicatorView: NVActivityIndicatorView, button: UIButton) {
        activityIndicatorView.isHidden = !shown
        button.isHidden = shown
    }
    
    //Share
    func didTapShareButton(view: UIView) {
        guard let image = RenderImageService.convertViewIntoImage(view: view) else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    
    //UnLike (Images)
    func didTapeUnlikeButton(id: String) {
        CoreDataManager.deleteFavoriteImage(id: id)
        navigationController?.popViewController(animated: true)
    }
    
    func checkFavoriteImage(favoritesImages: [FavoriteImage], id: String) -> Bool {
        var isAdded = false
        guard favoritesImages.count != 0 else { return false }
        for  favoriteImage in favoritesImages {
            if id == favoriteImage.id {
                isAdded = true
                break
            }
        }
        return isAdded
    }
    
    //UnFavorite (Quotes)
    func didTapUnfavoriteButton(id: String?) {
        CoreDataManager.deleteFavoriteQuoteFromList(id: id ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    //Helper's methods FavoriteQuote
    func checkFavoriteQuote(favoritesQuotes: [FavoriteQuote], id: String) -> Bool {
        var isAdded = false
        guard favoritesQuotes.count != 0 else { return false }
        for favoriteQuote in favoritesQuotes {
            if id == favoriteQuote.id {
                isAdded = true
                break
            }
        }
        return isAdded
    }
    
    func updateButtonImage(check: Bool, checkedImage: String, uncheckedImage: String) -> UIImage {
        var image: UIImage!
        if check {
            image = UIImage(named: checkedImage)
        } else {
            image = UIImage(named: uncheckedImage)
        }
        return image
    }
    
    func setupButton(button: UIButton) {
        button.layer.cornerRadius = 5
    }
}



