//
//  FavoriteImageView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 29/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoriteImageView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    //MARK: - Properties
    var favoriteImageViewConfigure: FavoriteImage? {
        didSet {
            if let downloadUri = favoriteImageViewConfigure?.imageURL {
                favoriteImageView.sd_setImage(with: URL(string: downloadUri))
            }
        }
    }
}
