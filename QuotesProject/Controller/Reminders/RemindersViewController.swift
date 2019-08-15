//
//  RemindersViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import UserNotifications

class RemindersViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var hourLabel: UILabel!
    
    //MARK: - Properties
    let randomQuotesService = RandomQuotesService()
    var randomQuote: ContentsCategoryQuote?
    var hours = 0
    var minutes = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reminders"
    }
    
    //MARK: - Actions
    @IBAction func hoursValueChanged(_ sender: UISlider) {
        hoursSliderConfigure(sender)
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        fetchRandomQuoteData()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    private func hoursSliderConfigure(_ sender: UISlider) {
        let countmin = Int(Double(sender.value) * 14.4)
        var hour = countmin / 60
        let mins = countmin - (hour * 60)
        
        if hour >= 24 {
            hour -= 24
        }
        
        hours = hour
        minutes = roundToFives(x: Double(mins))
        
        if minutes == 60 {
            hours = hour + 1
            minutes = 0
        }
        
        self.hourLabel.text = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes))"
    }
    
    //Helper's methods to convert Double into Int (Minutes)
    private func roundToFives(x : Double) -> Int {
        return 5 * Int(round(x / 5.0))
    }
}

//MARK: - Fetch Data
extension RemindersViewController {
    private func fetchRandomQuoteData() {
        randomQuotesService.getRandomQuote { (success, contentsCategoryQuote) in
            if success {
                self.randomQuote = contentsCategoryQuote
                self.notificationsSetup(quote: contentsCategoryQuote)
            } else {
                self.showAlert(title: "Sorry!", message: "No quote for such category exists!")
            }
        }
    }
}

//MARK: - Local Notifications Setup
extension RemindersViewController {
    private func notificationsSetup(quote: ContentsCategoryQuote?) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = quote?.contents.author ?? ""
        content.body = quote?.contents.quote ?? ""
        content.sound = UNNotificationSound.default
        
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        
        var dateComponents = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = 0
        
        guard let date = gregorian.date(from: dateComponents) else { return }
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        print(hours)
        print(minutes)
    }
}
