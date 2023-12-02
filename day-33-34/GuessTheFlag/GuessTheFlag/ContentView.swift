//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tyler Milner on 8/1/23.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var questionNumber = 1
    private let numberOfQuestions = 8
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    private static let numberOfFlags = 3
    @State private var tappedFlagNumber: Int? = nil
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<ContentView.numberOfFlags, id: \.self) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == tappedFlagNumber ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(tappedFlagNumber == nil ? 1.0 : (number != tappedFlagNumber ? 0.25 : 1.0))
                        .scaleEffect(tappedFlagNumber == nil ? 1.0 : (number != tappedFlagNumber ? 0.5 : 1.0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore)")
        }
        .alert("Game Over", isPresented: $showingFinalScore) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(currentScore) / \(numberOfQuestions)")
        }
    }
    
    func flagTapped(_ number: Int) {
        tappedFlagNumber = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            let tappedCountry = countries[number]
            scoreTitle = "Wrong! That's the flag of \(tappedCountry)"
            currentScore -= 1
        }
        
        if questionNumber == numberOfQuestions {
            showingFinalScore = true
        } else {
            questionNumber += 1
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tappedFlagNumber = nil
    }
    
    func reset() {
        currentScore = 0
        questionNumber = 1
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
