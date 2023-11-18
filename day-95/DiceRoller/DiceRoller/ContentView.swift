//
//  ContentView.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var diceRolls = DiceRolls()
    
    var body: some View {
        TabView {
            RollDiceView()
                .tabItem {
                    Label("Roll", systemImage: "dice")
                }
            
            PreviousRollsView()
                .tabItem {
                    Label("Previous Rolls", systemImage: "clock.arrow.circlepath")
                }
        }
        .environmentObject(diceRolls)
    }
}

#Preview {
    ContentView()
}
