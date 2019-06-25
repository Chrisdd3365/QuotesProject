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
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    @IBAction func timesValueChanged(_ sender: UIStepper) {
        timeInterval = Int(sender.value)
        remindersScrollView.timesLabel.text = timeInterval.description + "x"
    }
    
    @IBAction func hoursValueChanged(_ sender: UIStepper) {
        remindersScrollView.hoursLabel.text = Int(sender.value).description + " hour"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SeguesIdentifiers.timeIntervalSegue,
            let quoteVC = segue.destination as? QuoteViewController {
            quoteVC.timeInterval = timeInterval
       
        }
    }
    
    
}
