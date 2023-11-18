//
//  RollDiceView.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import SwiftUI

struct RollDiceView: View {
    @EnvironmentObject private var diceRolls: DiceRolls
    
    private let dice = Dice()
    
    var body: some View {
        NavigationView {
            VStack {
                if let lastRoll = diceRolls.lastRoll {
                    Text("\(lastRoll.value)")
                }
                
                Button("Roll") {
                    let roll = dice.roll()
                    diceRolls.add(roll)
                }
            }
            .navigationTitle("DiceRoller")
        }
    }
}

#Preview {
    RollDiceView()
        .environmentObject(DiceRolls())
}
