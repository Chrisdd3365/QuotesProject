//
//  UILabel.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 26/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

extension UILabel {
    //MARK: - Methods
    func setupShadowLabel(label: UILabel) {
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.9
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
