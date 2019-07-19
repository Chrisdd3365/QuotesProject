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
    func didTapShareButton(quote: String, author: String) {
        let activityController = UIActivityViewController(activityItems: ["Hey! Check out this quote!", quote, author], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    func didTapFavoriteButton(quote: String, author: String) {
        CoreDataManager.saveFavoritesQuotes(quote: quote, author: author)
    }
}
