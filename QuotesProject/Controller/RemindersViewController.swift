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
    @IBOutlet weak var remindersScrollView: RemindersScrollView!
    
    //MARK: - Properties
    var timeInterval = 0
    var hours = 0
    var minutes = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    @IBAction func repeatsValueChanged(_ sender: UISlider) {
        timeInterval = Int(sender.value)
        remindersScrollView.timesLabel.text = timeInterval.description + "x"
    }
    
    @IBAction func startingHourValueChanged(_ sender: UISlider) {
        let countmin = Int(Double(sender.value)*14.4)
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
        
        remindersScrollView.hoursLabel.text = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes))"
    }
    
    private func roundToFives(x : Double) -> Int {
        return 5 * Int(round(x / 5.0))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SeguesIdentifiers.timeIntervalSegue,
            let quoteVC = segue.destination as? QuoteViewController {
            quoteVC.timeInterval = timeInterval
            quoteVC.hours = hours
            quoteVC.minutes = minutes
        }
    }
}
