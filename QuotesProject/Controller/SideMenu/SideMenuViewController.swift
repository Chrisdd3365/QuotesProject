//
//  SideMenuViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 18/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import KRProgressHUD

class SideMenuViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    //MARK: - Properties
    let cellsTitles = ["Random Quotes", "Categories of Quotes", "Favorites Quotes", "My Own Quotes", "Random Images", "Categories of Images", "Favorites Images", "Reminders"]
    
    let cellsImages = [UIImage(named: "randomQuotes"), UIImage(named: "categories"), UIImage(named: "favorite"), UIImage(named: "write"), UIImage(named: "image"), UIImage(named: "categoriesImages"), UIImage(named: "favoritesImages"), UIImage(named: "reminder")]
    
    let seguesIdentifiers = ["RandomQuotes", "CategoriesQuotes", "FavoritesQuotes", "MyOwnQuotes", "RandomImages", "CategoriesImages", "FavoritesImages", "Reminders"]
    
    let randomQuotesService = RandomQuotesService()
    var randomQuotes: [RandomQuotes] = []
    
    let randomImageService = RandomImageService()
    var imageQuote: ContentsImage?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTableView.tableFooterView = UIView()
        navigationItem.title = "Menu"
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
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case seguesIdentifiers[0]:
            let randomQuotesVC = segue.destination as? RandomQuotesViewController
            randomQuotesVC?.randomQuotes = randomQuotes
        case seguesIdentifiers[4]:
            let randomImagesVC = segue.destination as? RandomImagesViewController
            randomImagesVC?.imageQuote = imageQuote
        default:
            break
        }
    }
}

//MARK: - Fetch Data
extension SideMenuViewController {
    private func fetchRandomQuotesData() {
        KRProgressHUD.show()
        KRProgressHUD.show(withMessage: "Loading...")
        
        randomQuotesService.getRandomQuotes { (success, randomQuotes) in
            KRProgressHUD.dismiss()
    
            if success {
                self.randomQuotes = randomQuotes
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: self.seguesIdentifiers[0], sender: nil)
                }
            } else {
                KRProgressHUD.dismiss()
                self.showAlert(title: "Sorry!", message: "Random Quotes not available!")
            }
        }
    }
    
    private func fetchRandomImageQuoteData() {
        KRProgressHUD.show()
        KRProgressHUD.show(withMessage: "Loading...")
        
        randomImageService.getRandomImage { (success, contentsImage) in
            KRProgressHUD.dismiss()
            
            if success {
                self.imageQuote = contentsImage
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: self.seguesIdentifiers[4], sender: nil)
                }
            } else {
                KRProgressHUD.dismiss()
                self.showAlert(title: "Sorry!", message: "Image not available!")
            }
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
        switch indexPath.row {
            case 0:
                fetchRandomQuotesData()
            case 4:
                fetchRandomImageQuoteData()
            default:
                performSegue(withIdentifier: seguesIdentifiers[indexPath.row], sender: self)
        }
    }
}
