//
//  DisplayMyOwnQuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 09/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayMyOwnQuoteViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var myOwnQuoteView: MyOwnQuoteView!
    
    //MARK: - Properties
    var myOwnQuoteSelected: MyOwnQuote?
    var imagePicker: ImagePicker?

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myOwnQuoteViewSetup()
        imagePickerDelegate()
        myOwnQuoteView.setupBorder(view: myOwnQuoteView)
        navigationItem.title = "My Own Quote"
    }
    
    //MARK: - Actions
    @IBAction func takePicture(_ sender: UIButton) {
        self.imagePicker?.present(from: sender)
    }
    
    @IBAction func shareMyOwnQuote(_ sender: UIButton) {
        didTapShareButton(view: myOwnQuoteView)
    }
    
    //MARK: - Methods
    private func imagePickerDelegate() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
    }
    
    private func myOwnQuoteViewSetup () {
        myOwnQuoteView.myOwnQuoteViewConfigure = myOwnQuoteSelected
    }
}

extension DisplayMyOwnQuoteViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.myOwnQuoteView.backgroundImage.image = image
    }
}
