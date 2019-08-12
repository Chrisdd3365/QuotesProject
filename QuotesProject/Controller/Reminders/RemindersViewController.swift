//
//  RemindersViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import UserNotifications
import DLLocalNotifications

class RemindersViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var hourLabel: UILabel!
    
    //MARK: - Properties
    let randomQuotesService = RandomQuotesService()
    var randomQuote: Contents?
    var hours = 0
    var minutes = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    @IBAction func hoursValueChanged(_ sender: UISlider) {
        let countmin = Int(Double(sender.value) * 14.4)
        //var string = ""
        var hour = countmin / 60
        let mins = countmin - (hour * 60)
        
        if hour >= 24 {
            hour -= 24
        }
        
        hours = hour
        minutes = roundToFives(x: Double(mins))
        
        // This fixes when you have hh:60. For instance, it fixes 7:60 to 8:00
        if minutes == 60 {
            hours = hour + 1
            minutes = 0
        }
        
        self.hourLabel.text = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)) "
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        fetchRandomQuoteData()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    private func roundToFives(x : Double) -> Int {
        return 5 * Int(round(x / 5.0))
    }
    
    //Fetch random quote data
    private func fetchRandomQuoteData() {
        randomQuotesService.getRandomQuote { (success, contents) in
            if success {
                self.randomQuote = contents
                self.notificationsSetup(randomQuote: contents)
            } else {
                self.showAlert(title: "Sorry!", message: "No quote for such category exists!")
            }
        }
    }
    
    private func notificationsSetup(randomQuote: Contents?) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = randomQuote?.contents.author ?? ""
        content.body = randomQuote?.contents.quote ?? ""
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
