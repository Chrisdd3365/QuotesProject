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
    @IBOutlet var quotesView: QuotesView!
    
    //MARK: - Properties
    let quotesService = QuotesService()
    var timeInterval = 1
    var hours = 0
    var minutes = 0

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuoteData()
        self.navigationItem.setHidesBackButton(true, animated: false)


    }
    
    //MARK: - Methods
    private func displayContents(quote: [Quote]) {
        quotesView.quoteTextView.text = quote[0].quote
        quotesView.authorLabel.text = quote[0].author
    }
    
    private func fetchQuoteData() {
        quotesService.getQuote { (success, contentsResponse) in
            if success {
                self.displayContents(quote: contentsResponse?.contents.quotes ?? [])
                self.notifications(quote: contentsResponse?.contents.quotes ?? [] )
            } else {
                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
            }
        }
    }
    
    private func notifications(quote: [Quote]) {
        //Content
        let content = UNMutableNotificationContent()
        content.title = quote[0].author
        content.body = quote[0].quote
        content.sound = UNNotificationSound.default
        
        //Trigger
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalTrigger()), repeats: true)
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        dateComponents.minute = minutes
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
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
