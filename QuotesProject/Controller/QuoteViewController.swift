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
    var timeInterval = 0
    var startHour = 0
    var startMinute = 0
    var endHour = 0
    var endMinute = 0
    

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
                self.scheduleNotifs(quote: contentsResponse?.contents.quotes ?? [], from: [18, 45], to: [18, 50], with: 5)
                //self.notifications(quote: contentsResponse?.contents.quotes ?? [] )
            } else {
                self.showAlert(title: "Sorry!", message: "Quote of the day not available!")
            }
        }
    }
    
    func scheduleNotifs(quote: [Quote], from startDate: Date, to endDate: Date, with interval: TimeInterval) {
        var curDate = startDate
        var count: Int = 0
        while curDate.compare(endDate) != .orderedDescending {
            scheduleNotif(quote: quote, date: curDate)
            curDate = curDate.addingTimeInterval(interval)
            count += 1
        }
    }
    
    private func scheduleNotif(quote: [Quote], date: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = quote[0].author
        content.body = quote[0].quote
        content.sound = UNNotificationSound.default
        
        let triggerTime = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
    
    
//    private func notifications(quote: [Quote]) {
//        //Content
//        let content = UNMutableNotificationContent()
//        content.title = quote[0].author
//        content.body = quote[0].quote
//        content.sound = UNNotificationSound.default
//
//
//        //let date = Date(timeIntervalSinceNow: 5)
//        let dateComponents = DateComponents(hour: 17, minute: 33)
//        var triggerDaily = Calendar.current.date(Date(), matchesComponents: dateComponents)
//        let triggger = UNNotificationTrigger
//
//        if  triggerDaily == true {
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalTrigger()), repeats: true)
//            triggerDaily = true
//            let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: triggerDaily)
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//            print("marche")
//        }
  
        
        
      
        
        
        
//        var dateComponents = DateComponents()
//
//        if dateComponents.hour == startHour && dateComponents.minute == startMinute {
//            //Trigger
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalTrigger()), repeats: true)
//            print("ca marche")
//            //Request
//            let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//        } else if dateComponents.hour == endHour && dateComponents.minute == endMinute {
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//            print("ca desactive")
//        }
//    }
    
    //HELPER
    private func timeIntervalTrigger() -> Int {
        if timeInterval == 0 {
            return 3600/1
        }
        return 3600 / timeInterval
    }
}
