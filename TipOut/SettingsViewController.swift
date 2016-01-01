//
//  SettingsViewController.swift
//  TipOut
//
//  Created by Cristiano Miranda on 12/31/15.
//  Copyright © 2015 Cristiano Miranda. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var custom: UITextField!
    
    var percentages = ["15%", "18%", "22%", "25%", "28%"]
    
    var pickerRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let userData = NSUserDefaults.standardUserDefaults()
        pickerRow = userData.integerForKey("pickerRow")
        
        if(pickerRow-- != 0)
        {
            picker.selectRow(pickerRow, inComponent: 0, animated: true)
        }
        else
        {
            picker.selectRow(2, inComponent: 0, animated: true)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return percentages.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return percentages[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // CLEAR CUSTOM FIELD
        custom.text = ""
        
        // SEND DATE TO TIP CALC
        pickerRow = row + 1
        NSUserDefaults.standardUserDefaults().setObject(pickerRow, forKey: "pickerRow")
        NSUserDefaults.standardUserDefaults().setObject("NULL", forKey: "custom")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(custom.text, forKey: "custom")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
