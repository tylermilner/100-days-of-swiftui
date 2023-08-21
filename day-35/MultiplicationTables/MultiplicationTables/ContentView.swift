//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Tyler Milner on 8/20/23.
//

import SwiftUI

struct MultiplicationQuestion {
    let firstNumber: Int
    let secondNumber: Int
    
    var question: String {
        "What is \(firstNumber) x \(secondNumber)?"
    }
    
    var answer: Int {
        firstNumber * secondNumber
    }
    
    var answerDescription: String {
        "\(firstNumber) x \(secondNumber) = \(answer)"
    }
}

extension MultiplicationQuestion: Identifiable {
    var id: String {
        "\(firstNumber)x\(secondNumber)"
    }
}

struct ContentView: View {
    @State private var showingSettings = true
    
    private static let minimumTableOption = 2
    private static let maximumTableOption = 12
    @State private var maximumTable = minimumTableOption
    
    private static let numberOfQuestionsOptions = [5, 10, 20]
    @State private var numberOfQuestions = numberOfQuestionsOptions[0]
    
    @State private var questions: [MultiplicationQuestion] = []
    @State private var currentQuestion = 0
    
    @State private var answer = ""
    @State private var correctAnswers = 0
    @State private var resultTitle = ""
    @State private var resultMessage = ""
    @State private var showingResult = false
    @State private var showingFinalScore = false
    
    var body: some View {
        if showingSettings {
            NavigationView {
                Form {
                    Section("Settings") {
                        Stepper("Tables up to...\(maximumTable)", value: $maximumTable, in: ContentView.minimumTableOption...ContentView.maximumTableOption)
                        
                        Picker("Number of questions", selection: $numberOfQuestions) {
                            ForEach(ContentView.numberOfQuestionsOptions, id: \.self) {
                                Text("\($0) questions")
                            }
                        }
                    }
                }
                .navigationTitle("Multiplication Tables")
                .toolbar {
                    Button("Start", action: start)
                }
            }
        } else {
            VStack {
                Spacer()
                
                Text(questions[currentQuestion].question)
                
                TextField("Answer", text: $answer)
                
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
    
    private func start() {
        // Generate questions
        self.questions = (0..<numberOfQuestions).map { _ in
            let firstNumber = generateRandomNumber()
            let secondNumber = generateRandomNumber()
            
            return MultiplicationQuestion(firstNumber: firstNumber, secondNumber: secondNumber)
        }
        
        // Start the game
        showingSettings = false
    }
    
    private func generateRandomNumber() -> Int {
        let lowerBound = 1
        let upperBound = maximumTable
        
        return Int.random(in: lowerBound...upperBound)
    }
    
    private func submitAnswer() {
        let question = questions[currentQuestion]
        
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
        if currentQuestion == questions.count - 1 {
            showingFinalScore = true
        } else {
            answer = ""
            currentQuestion += 1
        }
    }
    
    private func restart() {
        showingSettings = true
        correctAnswers = 0
        questions = []
        currentQuestion = 0
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
