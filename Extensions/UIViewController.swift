//
//  UIViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 13/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

extension UIViewController {
    //Alert
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //Share
    func didTapShareButton(myOwnQuote: String, author: String) {
        let activityController = UIActivityViewController(activityItems: ["Hey! Check out this quote!", myOwnQuote, author], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    func didTapShareButton2(favoriteQuote: String, author: String) {
        let activityController = UIActivityViewController(activityItems: ["Hey! Check out this quote!", favoriteQuote, author], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}
