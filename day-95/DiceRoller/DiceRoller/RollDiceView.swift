//
//  RollDiceView.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import SwiftUI

struct RollDiceView: View {
    @EnvironmentObject private var diceRolls: DiceRolls
    
    @State private var numberOfDice = 1
    @State private var numberOfSidesPerDice = diceSizes.first!
    
    private static let diceSizes = [4, 6, 8, 10, 12, 20, 100]
    
    private var dice: [Dice] {
        return Array(repeating: Dice(numberOfSides: numberOfSidesPerDice), count: numberOfDice)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Options") {
                    Stepper("\(numberOfDice) dice", value: $numberOfDice, in: 1...10)
                    
                    Picker(selection: $numberOfSidesPerDice) {
                        ForEach(Self.diceSizes, id: \.self) { diceSize in
                            Text("\(diceSize)")
                        }
                    } label: {
                        Text("\(numberOfSidesPerDice) sided")
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button("Roll") {
                            let roll = DiceRoll(dice: dice)
                            diceRolls.add(roll)
                        }
                        
                        Spacer()
                    }
                }
                
                if let lastRoll = diceRolls.lastRoll {
                    Section("Total") {
                        Text("\(lastRoll.total)")
                            .font(.largeTitle)
                    }
                    
                    Section("Rolls") {
                        ForEach(0..<lastRoll.numberOfDiceRolled, id: \.self) { index in
                            let rollValue = lastRoll.rollValues[index]
                            Text("\(rollValue)")
                                .font(.title)
                        }
                    }
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
