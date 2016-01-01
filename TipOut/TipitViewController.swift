//
//  TipitViewController.swift
//  TipOut
//
//  Created by Cristiano Miranda on 12/31/15.
//  Copyright © 2015 Cristiano Miranda. All rights reserved.
//

import UIKit

class TipitViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    
    var percentages = [0.15, 0.18, 0.22, 0.25, 0.28, 0.3]
    var index = 0
    var custom = ""
    var defaultTip = 0.0
    var billData = -1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        let userData = NSUserDefaults.standardUserDefaults()
        index = userData.integerForKey("pickerRow")
        
        if(userData.stringForKey("custom") == nil || userData.stringForKey("custom") == "NULL")
        {
            if(index-- != 0)
            {
                defaultTip = percentages[index]
            }
            else
            {
                defaultTip = percentages[2]
            }
        }
        else
        {
            let x = NSString(string: userData.stringForKey("custom")!).doubleValue
            defaultTip = x / 100
        }
        
        billData = userData.doubleForKey("billAmount")
        
        if(billData != 0)
        {
            billField.text = String(format: "%.2f", billData)
            let tip = billData * defaultTip
            let total = billData + tip
            
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
        
        billField.becomeFirstResponder()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * defaultTip
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        
        NSUserDefaults.standardUserDefaults().setObject(billAmount, forKey: "billAmount")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
