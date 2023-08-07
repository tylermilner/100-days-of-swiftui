//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tyler Milner on 8/6/23.
//

import SwiftUI

enum Move {
    case rock
    case paper
    case scissors
    
    var name: String {
        switch self {
        case .rock:
            return "Rock"
        case .paper:
            return "Paper"
        case .scissors:
            return "Scissors"
        }
    }
    
    var emoji: String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📄"
        case .scissors:
            return "✂️"
        }
    }
    
    static let allMoves: [Move] = [.rock, .paper, .scissors]
    static let winningMoves: [Move] = [.paper, .scissors, .rock]
    static let losingMoves: [Move] = [.scissors, .rock, .paper]
}

struct ContentView: View {
    @State private var turn = 1
    @State private var moves = Move.allMoves
    @State private var appMoveSelection = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var showingScore = false
    
    private var appMove: Move {
        return moves[appMoveSelection]
    }
    
    var body: some View {
        VStack {
            Group {
                Spacer()
                Text("Score: \(score)")
                    .font(.headline)
                Spacer()
            }
            
            Group {
                Text(appMove.emoji)
                    .font(.system(size: 100))
                Text(appMove.name)
                    .font(.title2)
                Text(shouldWin ? "Win" : "Lose")
                    .font(.title)
                Text(shouldWin ? "What beats \(appMove.name)?" : "\(appMove.name) beats what?")
                    .font(.title3)
                    .padding()
            }
            
            Group {
                Spacer()
                
                VStack {
                    ForEach(moves, id: \.self) { option in
                        Button(option.emoji) {
                            optionTapped(option)
                        }
                        .font(.system(size: 80))
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
        .alert("Game Over", isPresented: $showingScore) {
            Button("Restart") {
                reset()
            }
        } message: {
            Text("Score: \(score)")
        }

    }
    
    func optionTapped(_ option: Move) {
        // Calculate score
        if shouldWin == true && option == Move.winningMoves[appMoveSelection] {
            print("\(option.name) beats \(appMove.name)")
            score += 1
        } else if shouldWin == false && option == Move.losingMoves[appMoveSelection] {
            print("\(appMove.name) beats \(option.name)")
            score += 1
        } else {
            if shouldWin {
                print("\(option.name) does not beat \(appMove.name)")
            } else {
                print("\(appMove.name) does not beat \(option.name)")
            }
            
            score -= 1
        }
        
        // Check for game end
        if turn == 10 {
            showingScore = true
        } else {
            turn += 1
            advanceTurn()
        }
    }
    
    func advanceTurn() {
        appMoveSelection = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
    
    func reset() {
        turn = 1
        score = 0
        advanceTurn()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
