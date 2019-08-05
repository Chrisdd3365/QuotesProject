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
    //MARK: - Outlet
    @IBOutlet weak var remindersScrollView: RemindersScrollView!
    
    //MARK: - Properties
    let categoryQuoteNotificationService = CategoryQuoteNotificationService()
    var categoryQuote: Contents?
    var interval = 0
    var startTimer = 0
    var endTimer = 0

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    @IBAction func repeatsValueChanged(_ sender: UISlider) {
        interval = Int(sender.value)
        remindersScrollView.timesLabel.text = interval.description
    }
    
    @IBAction func enableLocalNotifications(_ sender: UISwitch) {
        if remindersScrollView.localNotificationsSwitch.isOn  {

        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        }
    }
    
    @IBAction func startingHourValueChanged(_ sender: UISlider) {
        startTimer = Int((sender.value))
        remindersScrollView.startingTimeLabel.text = startTimer.description
    }
    
    @IBAction func endingHourValueChanged(_ sender: UISlider) {
        endTimer = Int((sender.value))
        remindersScrollView.endingTimeLabel.text = endTimer.description
    }
    
    @IBAction func validerAction(_ sender: UIButton) {
        _ = Timer.scheduledTimer(timeInterval: TimeInterval(interval),
                                 target: self,
                                 selector: #selector(fetchCategoryQuoteDataBackground),
                                 userInfo: nil,
                                 repeats: true)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
//    @objc private func fetchCategoryQuoteData() {
//        categoryQuoteService.getCategoryQuote(category: categoryQuote?.contents.requestedCategory ?? "") { (success, contents) in
//            if success {
//                self.categoryQuote = contents
//
//                    self.schedulerLocalNotification(authorTitle: contents?.contents.author ?? "", quoteBody: contents?.contents.quote ?? "", startTimer: Double(self.startTimer), endTimer: Double(self.endTimer), interval: Double(self.interval))
//                    print(self.startTimer)
//                    print(self.endTimer)
//                    print(self.interval)
//
//            } else {
//                self.showAlert(title: "Sorry!", message: "No quote for such category exists!")
//            }
//        }
//    }
    
    @objc private func fetchCategoryQuoteDataBackground() {
        categoryQuoteNotificationService.getCategoryQuoteBackground(category: categoryQuote?.contents.requestedCategory ?? "") { (success, contents) in
            if success {
                self.categoryQuote = contents

                self.schedulerLocalNotification(authorTitle: contents?.contents.author ?? "", quoteBody: contents?.contents.quote ?? "", startTimer: Double(self.startTimer), endTimer: Double(self.endTimer), interval: Double(self.interval))
                print(self.startTimer)
                print(self.endTimer)
                print(self.interval)

            } else {
                self.showAlert(title: "Sorry!", message: "No quote for such category exists!")
            }
        }
    }

    private func schedulerLocalNotification(authorTitle: String, quoteBody: String, startTimer: Double, endTimer: Double, interval: Double) {
        let scheduler = DLNotificationScheduler()
        // This notification repeats every 15 seconds from a time period starting from 15 seconds from the current time till 5 minutes from the current time
        scheduler.repeatsFromToDate(identifier: "Reminder Notification", alertTitle: authorTitle, alertBody: quoteBody, fromDate: Date().addingTimeInterval(TimeInterval(startTimer)), toDate: Date().addingTimeInterval(TimeInterval(endTimer)), interval: interval, repeats: .none)
        
        scheduler.scheduleAllNotifications()
    }
}
