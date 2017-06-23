//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Caelan Dailey on 6/6/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation

struct CalculatorModel {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi), // Double.pi
        "e": Operation.constant(M_E), // M_E
        "√": Operation.unaryOperation(sqrt), // sqrt
        "cos": Operation.unaryOperation(cos), // cos
        "sin": Operation.unaryOperation(sin), // cos
        "±" : Operation.unaryOperation({( -$0 ) }),
        "x":   Operation.binaryOperation({( $0 * $1) }),
        "=":    Operation.equals,
        "/":    Operation.binaryOperation({( $0 / $1) }),
        "-":    Operation.binaryOperation({( $0 - $1) }),
        "+":    Operation.binaryOperation({( $0 + $1) })
    ]
    
    mutating func performOperation(_ symbol: String) {
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
                pendingBinaryOperation = PendingBinaryOperation(function: function, firstOprand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
            
        }
    }
    
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOprand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOprand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
