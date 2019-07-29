//
//  FavoritesImagesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 29/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoritesImagesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var favoritesImagesCollectionView: UICollectionView!
    
    //MARK: - Properties
    var favoritesImages = FavoriteImage.all
    //CollectionView's property
    lazy var collectionView: UICollectionView = {
        favoritesImagesCollectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        return favoritesImagesCollectionView
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesImages = FavoriteImage.all
        favoritesImagesCollectionView.reloadData()
    }
    
    //MARK: - Methods
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SeguesIdentifiers.displayFavoriteImageSegue,
        let displayFavoriteImageVC = segue.destination as? DisplayFavoriteImageViewController,
        let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() {
            displayFavoriteImageVC.favoriteImageSelected = favoritesImages[indexPath.row]
        }
    }
}

extension FavoritesImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoritesImagesCollectionView.dequeueReusableCell(withReuseIdentifier: FavoritesImagesCollectionViewCell.identifierCell, for: indexPath) as? FavoritesImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let favoriteImage = favoritesImages[indexPath.row]
        cell.favoritesImagesCollectionViewCellConfigure = favoriteImage
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
    
        return cell
    }
}

extension FavoritesImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.favoritesImages.remove(at: indexPath.row)
        favoritesImagesCollectionView.deleteItems(at: [indexPath])
    }
}



//MARK: - CollectionViewDelegateFlowLayout's methods
extension FavoritesImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = favoritesImagesCollectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as! FooterCollectionReusableView
            return footerView
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return favoritesImages.isEmpty ? CGSize(width: view.frame.width, height: 100) : CGSize(width: 0, height: 0)
    }
}

//MARK: - SetConstraints method
extension FavoritesImagesViewController {
    private func setConstraints() {
        view.addSubview(collectionView)
        collectionView.setAnchors(top: favoritesImagesCollectionView.safeTopAnchor, leading: favoritesImagesCollectionView.safeLeadingAnchor, bottom: favoritesImagesCollectionView.bottomAnchor, trailing: favoritesImagesCollectionView.safeTrailingAnchor)
    }
}

