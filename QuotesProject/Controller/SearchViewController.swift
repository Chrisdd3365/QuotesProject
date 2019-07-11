//
//  SearchViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 11/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchTableView: UITableView!
    
    //MARK: - Properties
    let tableData = ["One","Two","Three","Twenty-One"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            searchTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        searchTableView.tableFooterView = UIView()
        searchTableView.reloadData()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.searchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        if (resultSearchController.isActive) {
            cell.quoteLabel.text = filteredTableData[indexPath.row]
            return cell
        } else {
            cell.quoteLabel.text = tableData[indexPath.row]
            return cell
        }
    }
}

//extension SearchViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return myOwnQuotes.isEmpty ? 220 : 0
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "Tap on the 'Write' Button to add your own quote into the list!"
//        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        label.textColor = .gray
//        return label
//    }
//}
