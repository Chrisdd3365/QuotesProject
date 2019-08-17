//
//  DisplayCategoryImageView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayCategoryImageView: UIView {
    //MARK: - Outlet
    @IBOutlet weak var categoryImageView: UIImageView!
    
    //MARK: - Property
    var categoryImageViewConfigure: ContentsImage? {
        didSet {
            if let imageQuoteURL = categoryImageViewConfigure?.contents.qimage.downloadUri {
                categoryImageView.sd_setImage(with: URL(string: imageQuoteURL))
            }
        }
    }
}
