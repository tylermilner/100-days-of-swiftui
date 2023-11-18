//
//  DiceRoll.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import Foundation

struct DiceRoll: Identifiable {
    var id = UUID()
    let value: Int
    
    init(dice: Dice) {
        value = Int.random(in: 1...dice.numberOfSides)
    }
}
