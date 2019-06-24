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
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    @IBAction func timesValueChanged(_ sender: UIStepper) {
        remindersScrollView.timesLabel.text = Int(sender.value).description + "x"
    }
    
    @IBAction func hoursValueChanged(_ sender: UIStepper) {
        remindersScrollView.hoursLabel.text = Int(sender.value).description + " hour"
    }
}
