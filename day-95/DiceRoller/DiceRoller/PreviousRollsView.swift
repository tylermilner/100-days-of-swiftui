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
                Text("\(roll.value)")
            }
            .navigationTitle("Previous Rolls")
        }
    }
}

#Preview {
    PreviousRollsView()
        .environmentObject(DiceRolls())
}
