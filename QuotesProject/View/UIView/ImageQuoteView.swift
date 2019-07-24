//
//  ImageQuoteView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class ImageQuoteView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var imageQuote: UIImageView!
    
    //MARK: - Property
    var imageQuoteViewConfigure: ContentsImage? {
        didSet {
            if let imageQuoteURL = imageQuoteViewConfigure?.contents.qimage.downloadUri {
                imageQuote.sd_setImage(with: URL(string: imageQuoteURL))
            }
        }
    }
}
