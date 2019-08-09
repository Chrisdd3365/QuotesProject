//
//  CategoriesQuotesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class CategoriesQuotesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var categoriesQuotesCollectionView: UICollectionView!
    
    //MARK: - Properties
    let categoryQuoteService = CategoryQuoteService()
    var categoryQuote: Contents?
    var categories = ["Family", "Friendship", "Wisdom", "Workout", "Work", "Love", "Success", "Will", "Motivation", "Relationship", "Trust", "Optimism"]
    
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
}

extension CategoriesQuotesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoriesQuotesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesQuotesCollectionViewCell.identifierCell, for: indexPath) as? CategoriesQuotesCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categoryLabel.setupShadowLabel(label: cell.categoryLabel)
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        return cell
    }
}

extension CategoriesQuotesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchCategoryQuoteData(category: categories[indexPath.row])
    }
}

extension CategoriesQuotesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = categoriesQuotesCollectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/4)
    }
}
