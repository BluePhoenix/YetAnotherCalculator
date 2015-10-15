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
            userIsTypingANumber = false
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
    
    @IBAction func squareRootTapped(sender: AnyObject) {
        userIsTypingANumber = false
        
        displayValue = sqrt(displayValue)
        
        numberOne = displayValue
        numberTwo = nil
    }
    
    @IBAction func percentageTapped(sender: AnyObject) {
        userIsTypingANumber = false
        
        numberTwo = displayValue
        if currentOperator == "+" || currentOperator == "-" {
            displayValue = (numberTwo! / 100) * numberOne!
        } else if currentOperator == "/" || currentOperator == "*" {
            displayValue = (numberTwo! / 100)
        }
        
        numberOne = displayValue
        numberTwo = nil
    }
    
    @IBAction func equalTouchUpInside(sender: UIButton) {
        userIsTypingANumber = false
        numberTwo = displayValue
        
        switch currentOperator {
        case "/":
            displayValue = numberOne! / numberTwo!
        case "*":
            displayValue = numberOne! * numberTwo!
        case "+":
            displayValue = numberOne! + numberTwo!
        case "-":
            displayValue = numberOne! - numberTwo!
        default:
            break
        }
        
        numberOne = displayValue
        numberTwo = nil
        
    }
    
    @IBAction func minusTenPercentTouchUpInside(sender: AnyObject) {
        userIsTypingANumber = false
        displayValue = displayValue * ((100-10)/100)
    }
    
    @IBAction func addTaxTouchUpInside(sender: AnyObject) {
        if let taxRate = userDefaults.objectForKey("taxRate") as! Double? {
            displayValue = (displayValue) * (1 + taxRate)
        }
    }
    
    @IBAction func memoryTouchUpInside(sender: UIButton) {
        memoryType = sender.currentTitle!
        
        switch memoryType {
        case "M+":
            savedNumber = savedNumber + displayValue
            userDefaults.setDouble(savedNumber, forKey: "savedNumber")
        case "M-":
            savedNumber = savedNumber - displayValue
            userDefaults.setDouble(savedNumber, forKey: "savedNumber")
        case "MC":
            savedNumber = 0
            userDefaults.removeObjectForKey("savedNumber")
            displayValue = 0
        case "MR":
            displayValue = userDefaults.doubleForKey("savedNumber")
        default:
            break
        }
        userIsTypingANumber = false
    }
    
    @IBAction func clearTouchUpInside(sender: AnyObject) {
        // Remove the last entered number
        if userIsTypingANumber {
            displayLabel.text = "0"
            userIsTypingANumber = false
        }
    }
    
    @IBAction func clearAll(sender: AnyObject) {
        // Reset everything
        resetState()
    }
    
    func resetState() {
        currentOperator = ""
        numberOne = nil
        numberTwo = nil
        displayValue = 0
        userDefaults.removeObjectForKey("savedNumber")
    }
}
