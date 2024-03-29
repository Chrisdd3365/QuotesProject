//
//  MyOwnQuotesViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 03/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit
import CoreData

class MyOwnQuotesViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var myOwnQuotesTableView: UITableView!

    //MARK: - Properties
    var myOwnQuotes = MyOwnQuote.all
    var quoteTextField: UITextField!
    var authorTextField: UITextField!
    var saveAction: UIAlertAction!

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addQuoteButtonConfigure()
        myOwnQuotesTableView.tableFooterView = UIView()
        navigationItem.title = "My Own Quotes"
    }
    
    //MARK: - Methods
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SeguesIdentifiers.displayMyOwnQuoteSegue,
            let displayMyOwnQuoteVC = segue.destination as? DisplayMyOwnQuoteViewController,
            let indexPath = self.myOwnQuotesTableView.indexPathForSelectedRow {
            let myOwnQuoteSelected = myOwnQuotes[indexPath.row]
            displayMyOwnQuoteVC.myOwnQuoteSelected = myOwnQuoteSelected
        }
    }
}

//MARK: - Alert Configure
extension MyOwnQuotesViewController {
    private func addQuoteButtonConfigure() {
        let addQuoteButton = UIButton(type: .custom)
        addQuoteButton.setImage(UIImage(named: "writeQuote.png"), for: .normal)
        addQuoteButton.addTarget(self, action: #selector(alertConfigure), for: .touchUpInside)
        addQuoteButton.frame = CGRect(x: 0, y: 0, width: 53, height: 53)
        
        let addQuoteBarButton = UIBarButtonItem(customView: addQuoteButton)
        self.navigationItem.rightBarButtonItem = addQuoteBarButton
    }

    @objc func alertConfigure() {
        let alert = UIAlertController(title: "Add your own quote", message: nil, preferredStyle: .alert)
        alert.addTextField { textFieldQuote in
            self.quoteTextField = textFieldQuote
            self.quoteTextField.placeholder = "Quote"
            self.quoteTextField.delegate = self
        }
        alert.addTextField { textFieldAuthor in
            self.authorTextField = textFieldAuthor
            self.authorTextField.placeholder = "Author (Optional)"
            self.authorTextField.delegate = self
        }
        
        saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textFieldQuote = alert.textFields?[0], let quote = textFieldQuote.text else { return }
            guard let textFieldAuthor = alert.textFields?[1], let author = textFieldAuthor.text else { return }
            
            self.myOwnQuotes.append(CoreDataManager.saveMyOwnQuote(quote: quote, author: author))
            self.myOwnQuotes = MyOwnQuote.all
            self.myOwnQuotesTableView.reloadData()
        }
        
        saveAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension MyOwnQuotesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        saveAction.isEnabled = (!string.isEmpty || range.length < (textField.text ?? "").count)
        
        if quoteTextField.text?.isEmpty == true && authorTextField.text?.isEmpty == false {
            saveAction.isEnabled = false
        }
        return true
    }
}

extension MyOwnQuotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOwnQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myOwnQuotesTableView.dequeueReusableCell(withIdentifier: MyOwnQuotesTableViewCell.identifier, for: indexPath) as? MyOwnQuotesTableViewCell else {
            return UITableViewCell()
        }
        
        let myOwnQuote = myOwnQuotes[indexPath.row]
        cell.selectionStyle = .none
        cell.myOwnQuotesCellConfigure = myOwnQuote
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .white
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(myOwnQuotes[indexPath.row])
            myOwnQuotes.remove(at: indexPath.row)
            CoreDataManager.saveContext()
            myOwnQuotesTableView.beginUpdates()
            myOwnQuotesTableView.deleteRows(at: [indexPath], with: .automatic)
            myOwnQuotesTableView.endUpdates()
        }
    }
}

extension MyOwnQuotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return myOwnQuotes.isEmpty ? 300 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Tap on the 'Write' Button to add your own quote into the list!"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }
}
