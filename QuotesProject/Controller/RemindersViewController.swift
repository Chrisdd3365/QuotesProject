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
    var startHour = 0
    var startMinute = 0
    var endHour = 0
    var endMinute = 0
    
    
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
        
        startHour = hour
        startMinute = roundToFives(x: Double(mins))
        
        // This fixes when you have hh:60. For instance, it fixes 7:60 to 8:00
        if startMinute == 60 {
            startHour = hour + 1
            startMinute = 0
        }
        
        remindersScrollView.startingTimeLabel.text = "\(String(format: "%02d", startHour)):\(String(format: "%02d", startMinute))"
    }
    
    @IBAction func endingHourValueChanged(_ sender: UISlider) {
        let countmin1 = Int(Double(sender.value)*14.4)
        var hour1 = countmin1 / 60
        let mins1 = countmin1 - (hour1 * 60)
        
        if hour1 >= 24 {
            hour1 -= 24
        }
        
        endHour = hour1
        endMinute = roundToFives(x: Double(mins1))
        
        // This fixes when you have hh:60. For instance, it fixes 7:60 to 8:00
        if endMinute == 60 {
            endHour = hour1 + 1
            endMinute = 0
        }
        
        remindersScrollView.endingTimeLabel.text = "\(String(format: "%02d", endHour)):\(String(format: "%02d", endMinute))"
    }
    
    private func roundToFives(x : Double) -> Int {
        return 5 * Int(round(x / 5.0))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SeguesIdentifiers.timeIntervalSegue,
            let quoteVC = segue.destination as? QuoteViewController {
            quoteVC.timeInterval = timeInterval
            quoteVC.startHour = startHour
            quoteVC.startMinute = startMinute
            quoteVC.endHour = endHour
            quoteVC.endMinute = endMinute
        }
    }
}
