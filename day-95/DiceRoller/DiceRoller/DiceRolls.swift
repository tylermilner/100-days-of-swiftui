//
//  DiceRolls.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import Foundation

@MainActor class DiceRolls: ObservableObject {
    @Published private(set) var rolls: [DiceRoll] = []
    
    var lastRoll: DiceRoll? {
        rolls.last
    }
    
    func add(_ roll: DiceRoll) {
        rolls.append(roll)
    }
}
