//
//  CategoriesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //MARK: - Properties
    let categoryQuoteService = CategoryQuoteService()
    var categoryQuote: Contents?
    var categories = ["Family", "Friendship", "Wisdom", "Workout", "Work hard", "Love"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Methods
    private func fetchCategoryQuoteData(category: String) {
        categoryQuoteService.getCategoryQuote(category: category) { (success, contents) in
            if success {
                self.categoryQuote = contents
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.SeguesIdentifiers.displayCategoryQuoteSegue, sender: nil)
                }
            } else {
                self.showAlert(title: "Sorry!", message: "No quote for such category exists!")
            }
        }
    }
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SeguesIdentifiers.displayCategoryQuoteSegue,
            let displayCategoryQuoteVC = segue.destination as? DisplayCategoryQuoteViewController {
            displayCategoryQuoteVC.categoryQuote = categoryQuote
        }
    }

    //Setup CollectionViewCell Layout
    private func categoriesCollectionViewLayoutConfigure() {
        let width = (view.frame.size.width) / 3
        let layout = categoriesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.categoryLabel.text = categories[indexPath.row]
        
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchCategoryQuoteData(category: categories[indexPath.row])
    }
}
