//
//  ViewController.swift
//  calc
//
//  Created by Tony MACK on 2017/10/09.
//  Copyright © 2017 Tony MACK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblDisplay: UILabel!
    var userIsTyping:Bool = false

    @IBAction func digits(_ sender: UIButton) {
        let digit = sender.currentTitle
        
        if userIsTyping {
            let currentTextInDisplay = lblDisplay.text!
            lblDisplay.text = currentTextInDisplay + digit!
        } else {
            lblDisplay.text = digit
            userIsTyping = true
        }
    }
    
    
    
    var displayValue: Double {
        get {
            return Double(lblDisplay.text!)!
        }
        set {
            lblDisplay.text = String(newValue)
        }
    }
    
    private var brain = CalcBrain()
    
    @IBAction func btnSymbol(_ sender: UIButton) {
        
        if userIsTyping {
            brain.setOpp(displayValue)
            userIsTyping = false
        }
        if let mathSymbol = sender.currentTitle {
         brain.performOpp(mathSymbol)
        }
        
        if let result = brain.result {
                displayValue = result
        }
    }

}

