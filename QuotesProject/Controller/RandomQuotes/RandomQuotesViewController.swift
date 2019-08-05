//
//  RandomQuotesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import UserNotifications

class RandomQuotesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var randomQuotesCollectionView: UICollectionView!

    //MARK: - Properties
    let randomQuotesService = RandomQuotesService()
    var randomQuotes = [RandomQuotes]()
    var favoritesQuotes = FavoriteQuote.all

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchQuoteData()
        randomQuotesCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        randomQuotesCollectionView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        //didTapShareButton(quote: <#T##String#>, author: <#T##String#>)
    }

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        //didTapFavoriteButton(quote: <#T##String#>, author: <#T##String#>)
        //favoritesQuotes = FavoritesQuotes.all
    }

    //MARK: - Methods
    private func fetchRandomQuotesData() {
//        randomQuotesService.getRandomQuotes { (success, randomQuote) in
//            if success {
//                for randomQuote in self.randomQuotes {
//                    randomQuote = randomQuote
//                }
//                self.imageQuote = contentsImage
//
//            } else {
//                self.showAlert(title: "Sorry!", message: "Image not available!")
//            }
//        }
    }

//    private func notifications(quotes: [QuoteOfTheDay]) {
//        //Content
//        let content = UNMutableNotificationContent()
//        content.title = quotes[0].author ?? ""
//        content.body = quotes[0].quote
//        content.sound = UNNotificationSound.default
//
//        //Trigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = 15
//        dateComponents.minute = 38
//        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalTrigger()), repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: false)
//        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        //Request
//        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//    }
    
//    //HELPER
//    private func timeIntervalTrigger() -> Int {
//        if timeInterval == 0 {
//            return 3600/1
//        }
//        return 3600 / timeInterval
//    }
}

extension RandomQuotesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomQuotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = randomQuotesCollectionView.dequeueReusableCell(withReuseIdentifier: RandomQuotesCollectionViewCell.identifier, for: indexPath) as? RandomQuotesCollectionViewCell else {
            return UICollectionViewCell() }
        
        let randomQuote = randomQuotes[indexPath.row]
        cell.randomQuotesView.randomQuotesViewConfigure = randomQuote
        
        return cell
    }
}

