//
//  Dice.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import Foundation

struct Dice {
    let numberOfSides = 6
    
    func roll() -> DiceRoll {
        return DiceRoll(dice: self)
    }
}
