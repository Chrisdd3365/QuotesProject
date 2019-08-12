//
//  NotificationsManager.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import UserNotifications
import DLLocalNotifications

class NotificationsManager {
    static func schedulerLocalNotification(authorTitle: String, quoteBody: String, startTimer: Double, endTimer: Double, interval: Double) {
        let scheduler = DLNotificationScheduler()
        
        scheduler.repeatsFromToDate(identifier: "Reminder Notification", alertTitle: authorTitle, alertBody: quoteBody, fromDate: Date().addingTimeInterval(TimeInterval(startTimer)), toDate: Date().addingTimeInterval(TimeInterval(endTimer)), interval: interval, repeats: .none)
        
        scheduler.scheduleAllNotifications()
    }
}
