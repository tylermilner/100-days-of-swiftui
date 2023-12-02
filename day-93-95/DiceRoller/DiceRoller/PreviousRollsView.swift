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
                VStack(alignment: .leading) {
                    Text("\(roll.total)")
                        .font(.headline)
                    
                    HStack {
                        ForEach(0..<roll.numberOfDiceRolled, id: \.self) { index in
                            let rollValue = roll.rollValues[index]
                            Text("\(rollValue)")
                                .font(.subheadline)
                        }
                    }
                    .accessibilityElement(children: roll.rollValues.count > 1 ? .combine : .ignore)
                }
                .accessibilityElement(children: .combine)
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
