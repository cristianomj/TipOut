//
//  SuggestionViewController.swift
//  TipOut
//
//  Created by Cristiano Miranda on 12/31/15.
//  Copyright © 2015 Cristiano Miranda. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
