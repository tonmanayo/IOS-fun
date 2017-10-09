//
//  calcBrain.swift
//  calc
//
//  Created by tony mack on 10/9/17.
//  Copyright © 2017 tony mack. All rights reserved.
//

import Foundation

struct CalcBrain {
    
    private var accumulator: Double?
    
    mutating func performOpp(_ symbol: String) {

    }
    
    mutating func setOpp(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator //35
        }
    }
}
