//
//  CategoriesImagesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import KRProgressHUD

class CategoriesImagesViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var categoriesImagesCollectionView: UICollectionView!
    
    //MARK: - Properties
    let categoryImageService = CategoryImageService()
    var categoryImage: ContentsImage?
    
    var categories = ["Books", "Business", "Courage", "Death", "Family", "Friendship", "Happiness", "Life", "Love", "Motivation", "Self-esteem", "Success", "Trust", "Relationship", "Wisdom", "Women", "Work"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories Images"
    }
    
    //MARK: - Methods
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SeguesIdentifiers.displayCategoryImageSegue,
            let displayCategoryImageVC = segue.destination as? DisplayCategoryImageViewController, let indexPath = categoriesImagesCollectionView.indexPathsForSelectedItems?.first {
            displayCategoryImageVC.categoryImage = categoryImage
            displayCategoryImageVC.categoryLabel = categories[indexPath.row]
        }
    }
}

//MARK: - Fetch Data
extension CategoriesImagesViewController {
    private func fetchCategoryImageData(category: String) {
        KRProgressHUD.show()
        KRProgressHUD.show(withMessage: "Loading...")
        
        categoryImageService.getCategoryImage(category: category) { (success, contentsImages) in
            KRProgressHUD.dismiss()
            
            if success {
                self.categoryImage = contentsImages
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.SeguesIdentifiers.displayCategoryImageSegue, sender: nil)
                }
            } else {
                KRProgressHUD.dismiss()
                self.showAlert(title: "Sorry!", message: "No image for such category exists!")
            }
        }
    }
}

extension CategoriesImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoriesImagesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesImagesCollectionViewCell.identifierCell, for: indexPath) as? CategoriesImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categoryLabel.setupShadowLabel(label: cell.categoryLabel)
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        return cell
    }
}

extension CategoriesImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchCategoryImageData(category: categories[indexPath.row])
    }
}

extension CategoriesImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = categoriesImagesCollectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/4)
    }
}
