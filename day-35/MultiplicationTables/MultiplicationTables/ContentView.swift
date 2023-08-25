//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Tyler Milner on 8/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSettings = true
    
    @State private var questions: [Question] = []
    @State private var questionNumber = 0
    
    @State private var answer = ""
    @State private var correctAnswers = 0
    @State private var resultTitle = ""
    @State private var resultMessage = ""
    @State private var showingResult = false
    @State private var showingFinalScore = false
    
    var body: some View {
        if showingSettings {
            SettingsView(startGameBlock: start)
        } else {
            VStack {
                Spacer()
                
                Text(questions[questionNumber].question)
                
                TextField("Answer", text: $answer)
                    .keyboardType(.numberPad)
                
                Button("Submit", action: submitAnswer)
                
                Spacer()
            }
            .alert(resultTitle, isPresented: $showingResult) {
                Button("Next Question", action: nextQuestion)
            } message: {
                Text(resultMessage)
            }
            .alert("Game Over", isPresented: $showingFinalScore) {
                Button("Play Again", action: restart)
            } message: {
                Text("You answered \(correctAnswers)/\(questions.count) correctly.")
            }
        }
    }
    
    private func start(maximumTable: Int, numberOfQuestions: Int) {
        // Generate questions
        self.questions = (0..<numberOfQuestions).map { _ in
            let firstNumber = generateRandomNumber(upTo: maximumTable)
            let secondNumber = generateRandomNumber(upTo: maximumTable)
            
            return Question(firstNumber: firstNumber, secondNumber: secondNumber)
        }
        
        // Start the game
        showingSettings = false
    }
    
    private func generateRandomNumber(upTo max: Int) -> Int {
        let lowerBound = 1
        let upperBound = max
        
        return Int.random(in: lowerBound...upperBound)
    }
    
    private func submitAnswer() {
        let question = questions[questionNumber]
        
        if Int(answer) == question.answer {
            correctAnswers += 1
            resultTitle = "Correct"
        } else {
            resultTitle = "Wrong"
        }
        
        resultMessage = question.answerDescription
        showingResult = true
    }
    
    private func nextQuestion() {
        if questionNumber == questions.count - 1 {
            showingFinalScore = true
        } else {
            answer = ""
            questionNumber += 1
        }
    }
    
    private func restart() {
        showingSettings = true
        correctAnswers = 0
        questions = []
        questionNumber = 0
        answer = ""
        resultTitle = ""
        resultMessage = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
