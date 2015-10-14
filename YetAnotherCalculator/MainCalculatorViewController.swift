//
//  MainCalculatorViewController.swift
//  YetAnotherCalculator
//
//  Created by Felix Barros on 10/13/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import UIKit

class MainCalculatorViewController: UIViewController {
    
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
    
    var userIsTypingANumber = false
    var currentOperator: String = ""
    var memoryType:  String = ""
    var numberOne:   Double? = nil
    var numberTwo:   Double? = nil
    var savedNumber: Double = 0.0
    var tax:         Double = 0.0

    let userDefaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func digitTouchUpInside(sender: UIButton) {
        if let digit = sender.currentTitle {
            if !userIsTypingANumber {
                displayLabel.text = ""
                displayLabel.text = digit
                userIsTypingANumber = true
            } else {
                displayLabel.text = displayLabel.text! + digit
            }
        }
    }
    
    @IBAction func operatorTouchUpInside(sender: UIButton) {
        // Symbol reference:  ÷ × − + √ % ⚙ =

        userIsTypingANumber = false
        guard let thisOperator = sender.currentTitle else {
            print("Error: current operator has no title")
            return
        }
        
        currentOperator = thisOperator
        
        if numberOne == nil && numberTwo == nil {
            switch currentOperator {
            case "÷":
                currentOperator = "/"
                numberOne = displayValue
            case "×":
                currentOperator = "*"
                numberOne = displayValue
            case "−":
                currentOperator = "-"
                numberOne = displayValue
            case "+":
                currentOperator = "+"
                numberOne = displayValue
            default:
                break
            }
        } else if numberOne != nil && numberTwo == nil {
            switch currentOperator {
            case "÷":
                currentOperator = "/"
                numberTwo = displayValue
                displayValue = numberOne! / numberTwo!
                numberOne = displayValue
                numberTwo = nil
            case "×":
                currentOperator = "*"
                numberTwo = displayValue
                displayValue = numberOne! * numberTwo!
                numberOne = displayValue
                numberTwo = nil
            case "−":
                currentOperator = "-"
                numberTwo = displayValue
                displayValue = numberOne! - numberTwo!
                numberOne = displayValue
                numberTwo = nil
            case "+":
                currentOperator = "+"
                numberTwo = displayValue
                displayValue = numberOne! + numberTwo!
                numberOne = displayValue
                numberTwo = nil
            default:
                break
            }
        }
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
