//
//  ViewController.swift
//  Calculator
//
//  Created by Caelan Dailey on 6/6/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOFTyping = false
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOFTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOFTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var model = CalculatorModel()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOFTyping {
            model.setOperand(displayValue)
            userIsInTheMiddleOFTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            model.performOperation(mathematicalSymbol)
        }
        if let result = model.result {
            displayValue = result
        }
    }
}

