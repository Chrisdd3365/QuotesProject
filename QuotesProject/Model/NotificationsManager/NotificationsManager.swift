//
//  NotificationsManager.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 10/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import DLLocalNotifications
import DateTimePicker

class NotificationsManager {
    static func localNotificationsSetup(contentsCategoryQuote: ContentsCategoryQuote?, date: Date?) {
        let notification = DLNotification(identifier: "quoteNotification", alertTitle: contentsCategoryQuote?.contents.author ?? "", alertBody: contentsCategoryQuote?.contents.quote ?? "", date: date, repeats: .daily)
        
        let scheduler = DLNotificationScheduler()
        scheduler.scheduleNotification(notification: notification)
        scheduler.scheduleAllNotifications()
    }
}
