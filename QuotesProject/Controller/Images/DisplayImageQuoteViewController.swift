//
//  DisplayImageQuoteViewController.swift
//  QuotesProject
//
//  Created by Christophe DURAND on 24/07/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import UIKit

class DisplayImageQuoteViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var imageQuoteView: ImageQuoteView!
    
    //MARK: - Properties
    var imageQuote: ContentsImage?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageQuoteViewSetup()

    }
    
    //MARK: - Methods
    private func imageQuoteViewSetup() {
        imageQuoteView.imageQuoteViewConfigure = self.imageQuote
    }
}
