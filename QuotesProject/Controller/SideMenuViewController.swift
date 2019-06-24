//
//  SideMenuViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 18/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    //MARK: - Properties
    let cellsTitles = ["Reminders", "Categories", "Favorites"]
    let cellsImages = [UIImage(named: "reminders"), UIImage(named: "categories"), UIImage(named: "favorites")]
    let seguesIdentifiers = ["Reminders", "Categories", "Favorites"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sideMenuTableView.reloadData()
    }
}

//MARK: - TableViewDataSource's methods
extension SideMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as? SideMenuTableViewCell else {
            return UITableViewCell()
        }

        cell.iconImageView.image = self.cellsImages[indexPath.row]
        cell.titleLabel.text = self.cellsTitles[indexPath.row]

        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: seguesIdentifiers[indexPath.row], sender: self)
    }
}


