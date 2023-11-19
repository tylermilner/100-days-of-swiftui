//
//  PreviousRollsView.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import SwiftUI

struct PreviousRollsView: View {
    @EnvironmentObject private var diceRolls: DiceRolls
    
    var body: some View {
        NavigationView {
            List(diceRolls.rolls) { roll in
                HStack {
                    ForEach(0..<roll.numberOfDiceRolled, id: \.self) { index in
                        let rollValue = roll.rollValues[index]
                        Text("\(rollValue)")
                    }
                }
            }
            .navigationTitle("Previous Rolls")
        }
    }
}

#Preview {
    let dice = Array(repeating: Dice(numberOfSides: 20), count: 10)
    let roll = DiceRoll(dice: dice)
    
    let diceRolls = DiceRolls()
    diceRolls.add(roll)
    
    return PreviousRollsView()
        .environmentObject(diceRolls)
}
