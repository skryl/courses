//
//  ViewController.swift
//  calc
//
//  Created by Alex Skryl on 6/20/15.
//  Copyright (c) 2015 Alex Skryl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isTypingNumber = false
    
    var brain = CalculatorBrain()
    
    var displayValue: Double {
        get {
           return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
           display.text = "\(newValue)"
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTypingNumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            isTypingNumber = true
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if isTypingNumber {
            enter()
        }
        
        if let result = brain.performOperation(operation) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func enter() {
        isTypingNumber = false
        
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    
}

