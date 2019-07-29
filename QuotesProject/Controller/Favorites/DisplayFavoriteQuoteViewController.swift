//
//  DisplayFavoriteQuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 23/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayFavoriteQuoteViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var favoriteQuoteView: FavoriteQuoteView!
    
    //MARK: - Properties
    var favoriteQuoteSelected: FavoriteQuote?
    var imagePicker: ImagePicker?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteQuoteViewSetup()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    
    //MARK: - Actions
    @IBAction func takePictures(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func shareFavoriteQuote(_ sender: UIButton) {
        didTapShareButton(view: favoriteQuoteView)
    }
    
    @IBAction func removeFromFavorite(_ sender: UIButton) {
        didTapUnfavoriteButton(id: favoriteQuoteSelected?.id)
    }
    
    //MARK: - Methods
    private func favoriteQuoteViewSetup() {
        favoriteQuoteView.favoriteQuoteViewConfigure = favoriteQuoteSelected
    }
}

extension DisplayFavoriteQuoteViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.favoriteQuoteView.backgroundImageView.image = image
    }
}
