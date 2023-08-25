//
//  Question.swift
//  MultiplicationTables
//
//  Created by Tyler Milner on 8/24/23.
//

import Foundation

struct Question {
    let firstNumber: Int
    let secondNumber: Int
    
    var question: String {
        "What is \(firstNumber) x \(secondNumber)?"
    }
    
    var answer: Int {
        firstNumber * secondNumber
    }
    
    var answerDescription: String {
        "\(firstNumber) x \(secondNumber) = \(answer)"
    }
}
