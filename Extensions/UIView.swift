//
//  UIView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 29/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

//Setup Layouts for FooterView into CollectionView
extension UIView {
    //Set anchors on each directions
    func setAnchors(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let leading = leading { leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true }
        if size.width != 0 { widthAnchor.constraint(equalToConstant: size.width).isActive = true }
        if size.height != 0 { heightAnchor.constraint(equalToConstant: size.height).isActive = true }
    }
    
    //Give a square ratio on a view
    func squareRatio() {
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    //Center a view against another one
    func center(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        }
        return leadingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        }
        return trailingAnchor
    }
    
    //CollectionView's Methods: to find the right indexPath
    func findCollectionView() -> UICollectionView? {
        if let collectionView = self as? UICollectionView {
            return collectionView
        } else {
            return superview?.findCollectionView()
        }
    }
    
    func findCollectionViewCell() -> UICollectionViewCell? {
        if let cell = self as? UICollectionViewCell {
            return cell
        } else {
            return superview?.findCollectionViewCell()
        }
    }
    
    func findCollectionViewIndexPath() -> IndexPath? {
        guard let cell = findCollectionViewCell(), let collectionView = cell.findCollectionView() else { return nil }
        
        return collectionView.indexPath(for: cell)
    }
    
    func setupBorder(view: UIView) {
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
    }
}


