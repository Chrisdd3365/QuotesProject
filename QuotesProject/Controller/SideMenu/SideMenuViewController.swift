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
    let cellsTitles = ["Reminders", "Categories", "Images", "Favorites", "My Own Quotes"]
    let cellsImages = [UIImage(named: "reminders"), UIImage(named: "categories"), UIImage(named: "image"), UIImage(named: "favorites"), UIImage(named: "write")]
    let seguesIdentifiers = ["Reminders", "Categories", "Images", "Favorites", "MyOwnQuotes"]
    let imageQuoteService = ImageQuoteService()
    var imageQuote: ContentsImage?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sideMenuTableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func dismissController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    private func fetchImageQuoteData() {
        imageQuoteService.getImageQuote { (success, contentsImage) in
            if success {
                self.imageQuote = contentsImage
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: self.seguesIdentifiers[2], sender: nil)
                }
            } else {
                self.showAlert(title: "Sorry!", message: "Image not available!")
            }
        }
    }
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguesIdentifiers[2],
            let displayImageQuoteVC = segue.destination as? DisplayImageQuoteViewController {
            displayImageQuoteVC.imageQuote = imageQuote
        }
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
        if indexPath.row == 2 {
            fetchImageQuoteData()
        } else {
            performSegue(withIdentifier: seguesIdentifiers[indexPath.row], sender: self)
        }
    }
}


