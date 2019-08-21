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
import DateTimePicker
import KRProgressHUD

class RemindersViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var createReminderButton: UIButton!
    
    //MARK: - Properties
    let randomQuoteService = RandomQuoteService()
    var randomQuote: ContentsCategoryQuote?
    var date: Date?

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createDateTimePicker()
        setupButton(button: createReminderButton)
        createReminderButtonIsEnabled(enabled: false)
        createReminderButtonBackgroundColorSetup()
        addTimeButtonConfigure()
        navigationItem.title = "Reminders"
    }
    
    //MARK: - Action
    @IBAction func doneAction(_ sender: UIButton) {
        fetchRandomQuoteData(date: date)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    private func createReminderButtonIsEnabled(enabled: Bool) {
        createReminderButton.isEnabled = enabled
    }
    
    private func createReminderButtonBackgroundColorSetup() {
        createReminderButton.backgroundColor = .lightGray
    }
}

//MARK: - Fetch Data
extension RemindersViewController {
    private func fetchRandomQuoteData(date: Date?) {
        randomQuoteService.getRandomQuote { (success, contentsCategoryQuote) in
            if success {
                self.randomQuote = contentsCategoryQuote
                NotificationsManager.localNotificationsSetup(contentsCategoryQuote: contentsCategoryQuote, date: date)
                KRProgressHUD.showSuccess()
                KRProgressHUD.showSuccess(withMessage: "Reminder Created")
            } else {
                self.showAlert(title: "Sorry!", message: "Random Quote not available!")
            }
        }
    }
}

//MARK: - Date Time Picker Configure Methods
extension RemindersViewController {
    private func addTimeButtonConfigure() {
        let addTimeButton = UIButton(type: .custom)
        addTimeButton.setImage(UIImage(named: "time.png"), for: .normal)
        addTimeButton.addTarget(self, action: #selector(createDateTimePicker), for: .touchUpInside)
        addTimeButton.frame = CGRect(x: 0, y: 0, width: 53, height: 53)
        
        let addTimeBarButton = UIBarButtonItem(customView: addTimeButton)
        self.navigationItem.rightBarButtonItem = addTimeBarButton
    }
    
    @objc private func createDateTimePicker() {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        picker.includeMonth = true
        picker.highlightColor = UIColor.black
        picker.darkColor = UIColor.black
        picker.doneButtonTitle = "Done"
        picker.doneBackgroundColor = UIColor.black
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            self.title = formatter.string(from: date)
        }
        picker.delegate = self
        picker.show()
    }
}

//MARK: - Date Time Picker Setup Delegate
extension RemindersViewController: DateTimePickerDelegate {
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        title = picker.selectedDateString
        date = picker.selectedDate
        
        if date == picker.selectedDate {
            createReminderButtonIsEnabled(enabled: true)
            createReminderButton.backgroundColor = .black
        }
    }
}
