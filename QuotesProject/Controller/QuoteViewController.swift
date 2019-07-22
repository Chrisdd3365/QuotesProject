//
//  QuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import UserNotifications

class QuoteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var quotesView: QuotesView!
    @IBOutlet weak var quotesCollectionView: UICollectionView!
    
    //MARK: - Properties
    let quoteOfTheDayService = QuoteOfTheDayService()
    var quotes = [Quote]()
    var favoritesQuotes = FavoritesQuotes.all
    var timeInterval = 0
    var startHour = 0
    var startMinute = 0
    var endHour = 0
    var endMinute = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuoteData()
        quotesCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        quotesCollectionView.reloadData()
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
    private func fetchQuoteData() {
//        quoteOfTheDayService.getQuote { (success, contentsResponse) in
//            if success {
//                self.quotes = contentsResponse?.contents.quotes ?? []
//                self.notifications(quotes: contentsResponse?.contents.quotes ?? [])
//            } else {
//                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
//            }
//        }
    }

    private func notifications(quotes: [Quote]) {
        //Content
        let content = UNMutableNotificationContent()
        content.title = quotes[0].author ?? ""
        content.body = quotes[0].quote
        content.sound = UNNotificationSound.default

        //Trigger
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 38
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalTrigger()), repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: false)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //Request
        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //HELPER
    private func timeIntervalTrigger() -> Int {
        if timeInterval == 0 {
            return 3600/1
        }
        return 3600 / timeInterval
    }
}

extension QuoteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = quotesCollectionView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.identifier, for: indexPath) as? QuoteCollectionViewCell else {
            return UICollectionViewCell() }
        
        let quote = quotes[indexPath.row]
        cell.quoteCollectionViewCellConfigure = quote
        
        return cell
    }
}
