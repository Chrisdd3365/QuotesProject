//
//  NotificationsManagerTests.swift
//  QuotesProjectTests
//
//  Created by Christophe DURAND on 19/08/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import XCTest
@testable import QuotesProject

class NotificationsManagerTests: XCTestCase {
    //MARK: - Properties
    let randomQuote: ContentsCategoryQuote? = nil
    let date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    
    //MARK: - Unit Testing Notifications Manager
    func testCreateNotifications() {
        NotificationsManager.localNotificationsSetup(contentsCategoryQuote: randomQuote, date: date)
        
        XCTAssert(true)
    }
}
