//
//  FavoritesImagesCollectionViewCell.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 29/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoritesImagesCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    //MARK: - Properties
    var favoritesImagesCollectionViewCellConfigure: FavoriteImage? {
        didSet {
            if let downloadUri = favoritesImagesCollectionViewCellConfigure?.imageURL {
                favoriteImageView.sd_setImage(with: URL(string: downloadUri))
            }
        }
    }
}
