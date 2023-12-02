//
//  Dice.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import Foundation

struct Dice {
    let numberOfSides: Int
    
    func roll() -> Int {
        return Int.random(in: 1...numberOfSides)
    }
}
