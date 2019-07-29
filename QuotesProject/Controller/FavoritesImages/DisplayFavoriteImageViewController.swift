//
//  DisplayFavoriteImageViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 29/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayFavoriteImageViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var favoriteImageQuoteView: FavoriteImageView!
    
    //MARK: - Properties
    var favoriteImageSelected: FavoriteImage?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteImageQuoteViewSetup()
        
    }
    
    //MARK: - Actions
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        didTapShareButton(view: favoriteImageQuoteView)
    }
    
    @IBAction func unlikeButtonTapped(_ sender: UIButton) {
        didTapeUnlikeButton(id: favoriteImageSelected?.id ?? "")
    }
    
    //MARK: - Methods
    private func favoriteImageQuoteViewSetup() {
        favoriteImageQuoteView.favoriteImageViewConfigure = favoriteImageSelected
    }
}
