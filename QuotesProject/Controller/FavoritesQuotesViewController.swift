//
//  FavoritesQuotesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoritesQuotesViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var favoritesQuotesTableView: UITableView!
    
    //MARK: - Properties
    var favoritesQuotes = FavoritesQuotes.all
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesQuotesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesQuotes = FavoritesQuotes.all
        favoritesQuotesTableView.reloadData()
    }
    
    //MARK: - Methods
    //Segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Constants.SeguesIdentifiers.displayMyOwnQuoteSegue,
//            let displayMyOwnQuoteVC = segue.destination as? DisplayMyOwnQuoteViewController,
//            let indexPath = self.favoritesQuotesTableView.indexPathForSelectedRow {
//            let favoriteQuoteSelected = favoritesQuotes[indexPath.row]
//            displayMyOwnQuoteVC.favoriteQuote = favoriteQuoteSelected
//        }
//    }
}

extension FavoritesQuotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesQuotesTableView.dequeueReusableCell(withIdentifier: FavoritesQuotesTableViewCell.identifier, for: indexPath) as? FavoritesQuotesTableViewCell else { return UITableViewCell()
        }
        
        let favoriteQuote = favoritesQuotes[indexPath.row]
        
        cell.selectionStyle = .none
        cell.favoritesQuotesCellConfigure = favoriteQuote
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(favoritesQuotes[indexPath.row])
            favoritesQuotes.remove(at: indexPath.row)
            CoreDataManager.saveContext()
            favoritesQuotesTableView.beginUpdates()
            favoritesQuotesTableView.deleteRows(at: [indexPath], with: .automatic)
            favoritesQuotesTableView.endUpdates()
        }
    }
}

extension FavoritesQuotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoritesQuotes.isEmpty ? 220 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Tap on the 'Favorite' Button to add your favorites quotes into the list!"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }
}
