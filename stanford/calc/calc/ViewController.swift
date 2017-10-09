//
//  ViewController.swift
//  calc
//
//  Created by tony mack on 10/9/17.
//  Copyright © 2017 tony mack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentTyping:Bool = false
    @IBOutlet weak var lblDisplay: UILabel!
    @IBAction func btnNumbers(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if currentTyping {
            let currentDisplay = lblDisplay!.text!
            lblDisplay.text = currentDisplay + digit
        } else {
            lblDisplay.text = digit
            currentTyping = true
        }
    }
    
    var displayValue:Double {
        get {
            return Double(lblDisplay.text!)!
        }
        set {
            lblDisplay.text = String(newValue)
        }
    }
    
    private var brain = CalcBrain()
    @IBAction func btnOperation(_ sender: UIButton) {
        if currentTyping {
            brain.setOpp(displayValue)
            currentTyping = false
        }
        
        
        if let symbol = sender.currentTitle {
            brain.performOpp(symbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
        
        
        
    }
    
}

