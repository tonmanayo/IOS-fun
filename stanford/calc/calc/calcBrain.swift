//
//  CalcBrain.swift
//  calc
//
//  Created by Tony MACK on 2017/10/10.
//  Copyright © 2017 Tony MACK. All rights reserved.
//

import Foundation

struct CalcBrain {
    
    private var accumulator: Double?
    
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> =
        [
            "pi": Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "±": Operation.unaryOperation({-$0}),
            "x": Operation.binaryOperation({$0 * $1}),
            "-": Operation.binaryOperation({$0 - $1}),
            "+": Operation.binaryOperation({$0 + $1}),
            "÷": Operation.binaryOperation({$0 / $1}),
            "=": Operation.equals
        ]
    
    mutating func performOpp(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals():
                performPendingBinaryOperation()
                break
           
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perfrom(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perfrom(with secondOperation: Double) -> Double {
             return function(firstOperand, secondOperation)
        }
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
