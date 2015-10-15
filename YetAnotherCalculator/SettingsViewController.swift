//
//  SettingsViewController.swift
//  YetAnotherCalculator
//
//  Created by Felix Barros on 10/14/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var taxRateTextField: UITextField!
    var taxRateValue: Double? {
        get {
            if let taxRate = Double(taxRateTextField.text!) {
                return taxRate/100.0
            } else {
                return nil
            }
        }
        set {
            if let newValidValue = newValue {
                taxRateTextField.text = String(format: "%.2f", (newValidValue * 100.0))
            }
        }
    }
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let taxRate = userDefaults.objectForKey("taxRate") as! Double? {
            taxRateValue = taxRate
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func applyTaxRateTouchUpInside(sender: AnyObject) {
        if let taxRate = taxRateValue {
            userDefaults.setDouble(taxRate, forKey: "taxRate")
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}
