//
//  DisplayMyOwnQuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayMyOwnQuoteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var myOwnQuoteView: MyOwnQuoteView!
    
    //MARK: - Properties
    var myOwnQuoteSelected: MyOwnQuotes?
    var imagePicker: ImagePicker?

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myOwnQuoteViewSetup()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    
    //MARK: - Actions
    @IBAction func takePicture(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func shareMyOwnQuote(_ sender: UIButton) {
        didTapShareButtonMyOwnQuote(view: myOwnQuoteView)
    }
    
    //MARK: - Method
    private func myOwnQuoteViewSetup () {
        myOwnQuoteView.myOwnQuoteViewConfigure = myOwnQuoteSelected
    }
}

extension DisplayMyOwnQuoteViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.myOwnQuoteView.backgroundImage.image = image
    }
}
