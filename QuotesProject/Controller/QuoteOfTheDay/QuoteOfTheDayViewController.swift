//
//  QuoteOfTheDayViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 19/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import BubbleTransition
import FanMenu

class QuoteOfTheDayViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var quoteOfTheDayView: QuoteOfTheDayView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var fanMenuView: FanMenu!
    
    //MARK: - Properties
    let quoteOfTheDayService = QuoteOfTheDayService()
    var favoritesQuotes = FavoriteQuote.all
    var imagePicker: ImagePicker?
    
    let transition = BubbleTransition()
    
    let seguesIdentifiers = ["RandomQuotes", "CategoriesQuotes", "FavoritesQuotes", "MyOwnQuotes", "RandomImages", "CategoriesImages", "FavoritesImages", "Reminders"]
    
    let randomQuotesService = RandomQuotesService()
    var randomQuotes: [RandomQuotes] = []
    
    let imageQuoteService = ImageQuoteService()
    var imageQuote: ContentsImage?
    
  
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuoteOfTheDayData()
        buttonsSetImage()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
        
        fanMenuView.button = FanMenuButton(
            id: "main",
            image: "menu",
            color: .white
        )
        
        fanMenuView.items = [
            FanMenuButton(
                id: "randomquotes_id",
                image: "randomQuotes",
                color: .white),
            FanMenuButton(
                    id: "categoriesofquotes_id",
                    image: "categories",
                    color: .white),
            FanMenuButton(id: "favoritesquotes_id", image: "favoritesQuotes", color: .white)
        ]
        
        fanMenuView.menuRadius = 90.0
        fanMenuView.duration = 0.2
        fanMenuView.delay = 0.05
        fanMenuView.interval = (Double.pi, 2 * Double.pi)
        
        fanMenuView.onItemDidClick = { button in
            if button.id == "randomquotes_id"{
            self.fetchRandomQuotesData()
            }
            print("ItemDidClick: \(button.id)")
        }
        
        fanMenuView.onItemWillClick = { button in
            print("ItemWillClick: \(button.id)")
        }
        
        fanMenuView.backgroundColor = .clear
    }
    
    private func fetchRandomQuotesData() {
        randomQuotesService.getRandomQuotes { (success, randomQuotes) in
            if success {
                self.randomQuotes = randomQuotes
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: self.seguesIdentifiers[0], sender: nil)
                }
            } else {
                self.showAlert(title: "Sorry!", message: "Random Quotes not available!")
            }
        }
    }
    
    private func fetchRandomImageQuoteData() {
        imageQuoteService.getImageQuote { (success, contentsImage) in
            if success {
                self.imageQuote = contentsImage
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: self.seguesIdentifiers[4], sender: nil)
                }
            } else {
                self.showAlert(title: "Sorry!", message: "Image not available!")
            }
        }
    }
    

    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination

        switch segue.identifier {
        case seguesIdentifiers[0]:
            let randomQuotesVC = segue.destination as? RandomQuotesViewController
            randomQuotesVC?.randomQuotes = randomQuotes
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
        case seguesIdentifiers[4]:
            let randomImagesVC = segue.destination as? RandomImagesViewController
            randomImagesVC?.imageQuote = imageQuote
        default:
            break
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesQuotes = FavoriteQuote.all
        buttonsSetImage()
    }

    //MARK: - Actions
    @IBAction func pickingPictures(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func shareQuoteOfTheDay(_ sender: UIButton) {
        didTapShareButton(view: quoteOfTheDayView)
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        addToFavoritesListSetup()
    }
    
    //MARK: - Methods
    private func fetchQuoteOfTheDayData() {
        quoteOfTheDayService.getQuoteOfTheDay { (success, contentsResponse) in
            if success {
                self.quoteOfTheDayView.quoteOfTheDayViewConfigure = contentsResponse
                self.buttonsSetImage()
            } else {
                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
            }
        }
    }
    
    private func addToFavoritesListSetup() {
        guard let contentsResponse = quoteOfTheDayView.quoteOfTheDayViewConfigure else { return }
        if checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: contentsResponse.contents.quotes[0].id) == false {
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            CoreDataManager.saveQuoteOfTheDayToFavoritesQuotes(contentsResponse: contentsResponse)
            favoritesQuotes = FavoriteQuote.all
        } else {
            favoritesQuotes = FavoriteQuote.all
            showAlert(title: "Sorry!", message: "You've already added this quote into your favorite list!")
        }
    }
    
    private func buttonsSetImage() {
        guard let contentsResponse = quoteOfTheDayView.quoteOfTheDayViewConfigure else { return }
        favoriteButton.setImage(updateButtonImage(check: checkFavoriteQuote(favoritesQuotes: favoritesQuotes, id: contentsResponse.contents.quotes[0].id), checkedImage: "favorite", uncheckedImage: "noFavorite"), for: .normal)
    }
    

}

extension QuoteOfTheDayViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.quoteOfTheDayView.backgroundImageView.image = image
    }
}

//MARK: UIViewControllerTransitioningDelegate
extension QuoteOfTheDayViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        //transition.startingPoint = sideMenuButton.center
        transition.startingPoint = fanMenuView.center
        transition.bubbleColor = .white
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        //transition.startingPoint = sideMenuButton.center
        transition.startingPoint = fanMenuView.center
        transition.bubbleColor = .white
        return transition
    }
}
