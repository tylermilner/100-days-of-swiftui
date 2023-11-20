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
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @State private var timerRollsRemaining = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var lastRoll: DiceRoll?
    
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
                            feedback.notificationOccurred(.success)
                            startTimer()
                        }
                        
                        Spacer()
                    }
                }
                
                if let lastRoll = lastRoll {
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
        .onReceive(timer) { time in
            guard isActive else { return }
            
            let roll = DiceRoll(dice: dice)
            lastRoll = roll
            
            if timerRollsRemaining > 0 {
                timerRollsRemaining -= 1
            } else {
                stopTimer()
                diceRolls.add(roll)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
        .onAppear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timerRollsRemaining = 10
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
    }
}

#Preview {
    RollDiceView()
        .environmentObject(DiceRolls())
}
