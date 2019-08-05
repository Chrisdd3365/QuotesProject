//
//  RemindersScrollView.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/06/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class RemindersScrollView: UIScrollView {
    //MARK: - Outlets
    @IBOutlet weak var localNotificationsSwitch: UISwitch!
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var startingTimeLabel: UILabel!
    @IBOutlet weak var endingTimeLabel: UILabel!
    @IBOutlet weak var timesSlider: UISlider!
    @IBOutlet weak var startingTimeSlider: UISlider!
    @IBOutlet weak var endingTimeSlider: UISlider!
}
