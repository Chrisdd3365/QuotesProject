//
//  UIViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 13/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

extension UIViewController {
    //MARK: - Methods
    //Alert
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //Share
    func didTapShareButton(view: QuoteOfTheDayView) {
        guard let image = RenderImageService.convertQuoteOfTheDayViewIntoImage(view: view) else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    func didTapShareButtonMyOwnQuote(view: MyOwnQuoteView) {
        guard let image = RenderImageService.convertMyOwnQuoteViewIntoImage(view: view) else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    func didTapShareButtonFavoriteQuote(view: FavoriteQuoteView) {
        guard let image = RenderImageService.convertFavoriteQuoteViewIntoImage(view: view) else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    //Favorite
    func didTapUnfavoriteButton(id: String?) {
        CoreDataManager.deleteFavoriteFromList(id: id ?? "")
        navigationController?.popViewController(animated: true)
    }
    
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
}



