//
//  RenderImageService.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 22/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

//Class managing the conversion of UIView into image
class RenderImageService {
    static func convertQuoteOfTheDayViewIntoImage(view: QuoteOfTheDayView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func convertMyOwnQuoteViewIntoImage(view: MyOwnQuoteView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
