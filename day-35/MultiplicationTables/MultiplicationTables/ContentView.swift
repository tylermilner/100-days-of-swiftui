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
    
    var answer: Int {
        firstNumber * secondNumber
    }
}

extension MultiplicationQuestion: Identifiable {
    var id: String {
        "\(firstNumber)x\(secondNumber)"
    }
}

struct ContentView: View {
    private static let minimumTableOption = 2
    private static let maximumTableOption = 12
    @State private var maximumTable = minimumTableOption
    
    private static let numberOfQuestionsOptions = [5, 10, 20]
    @State private var numberOfQuestions = numberOfQuestionsOptions[0]
    
    @State private var questions: [MultiplicationQuestion] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section("Practice") {
                    Stepper("Tables up to...\(maximumTable)", value: $maximumTable, in: ContentView.minimumTableOption...ContentView.maximumTableOption)
                    
                    Picker("Number of questions", selection: $numberOfQuestions) {
                        ForEach(ContentView.numberOfQuestionsOptions, id: \.self) {
                            Text("\($0) questions")
                        }
                    }
                }
                
                Section("Questions") {
                    List(questions) { question in
                        Text("\(question.firstNumber) x \(question.secondNumber) = \(question.answer)")
                    }
                }
            }
            .navigationTitle("Multiplication Tables")
            .toolbar {
                Button("Start", action: start)
            }
        }
    }
    
    func start() {
        // Generate questions
        self.questions = (0..<numberOfQuestions).map { _ in
            let firstNumber = generateRandomNumber()
            let secondNumber = generateRandomNumber()
            
            return MultiplicationQuestion(firstNumber: firstNumber, secondNumber: secondNumber)
        }
    }
    
    private func generateRandomNumber() -> Int {
        let lowerBound = 1
        let upperBound = maximumTable
        
        return Int.random(in: lowerBound...upperBound)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
