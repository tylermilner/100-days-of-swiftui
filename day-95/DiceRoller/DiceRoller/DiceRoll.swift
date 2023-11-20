//
//  DiceRoll.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import Foundation

struct DiceRoll: Identifiable {
    var id = UUID()
    let rollValues: [Int]
    
    var numberOfDiceRolled: Int {
        rollValues.count
    }
    
    var total: Int {
        var total = 0
        
        for value in rollValues {
            total += value
        }
        
        return total
    }
    
    init(dice: [Dice]) {
        var rollValues = [Int]()
        
        for dice in dice {
            let rollValue = dice.roll()
            rollValues.append(rollValue)
        }
        
        self.rollValues = rollValues
    }
}
