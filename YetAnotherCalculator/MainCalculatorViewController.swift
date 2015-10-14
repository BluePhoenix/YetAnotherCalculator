//
//  MainCalculatorViewController.swift
//  YetAnotherCalculator
//
//  Created by Felix Barros on 10/13/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import UIKit

class MainCalculatorViewController: UIViewController {
    /*
    Symbol reference:
    ÷ × − + √ % ⚙ =
    */
    @IBOutlet weak var displayLabel: UILabel!
    var displayValue: Double {
        get {
            if let value = Double(displayLabel.text!) {
                return value
            } else {
                // TODO: Revise if this should be the proper one to return
                return Double.infinity
            }
        }
        set {
            displayLabel.text = "\(newValue)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func digitTouchUpInside(sender: UIButton) {
    }
    
    @IBAction func operatorTouchUpInside(sender: UIButton) {
    }
    
    @IBAction func equalTouchUpInside(sender: UIButton) {
    }
    
    @IBAction func minusTenPercentTouchUpInside(sender: AnyObject) {
    }
    
    @IBAction func addTaxTouchUpInside(sender: AnyObject) {
    }
    
    @IBAction func memoryTouchUpInside(sender: UIButton) {
    }
    
    @IBAction func clearTouchUpInside(sender: AnyObject) {
    }
}
