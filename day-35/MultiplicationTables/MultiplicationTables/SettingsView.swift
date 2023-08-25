//
//  SettingsView.swift
//  MultiplicationTables
//
//  Created by Tyler Milner on 8/21/23.
//

import SwiftUI

struct SettingsView: View {
    private static let minimumTableOption = 2
    private static let maximumTableOption = 12
    @State private var maximumTable = minimumTableOption
    
    private static let numberOfQuestionsOptions = [5, 10, 20]
    @State private var numberOfQuestions = numberOfQuestionsOptions[0]
    
    var startGameBlock: (_ maximumTable: Int, _ numberOfQuestions: Int) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Settings") {
                    Stepper("Tables up to...\(maximumTable)", value: $maximumTable, in: SettingsView.minimumTableOption...SettingsView.maximumTableOption)

                    Picker("Number of questions", selection: $numberOfQuestions) {
                        ForEach(SettingsView.numberOfQuestionsOptions, id: \.self) {
                            Text("\($0) questions")
                        }
                    }
                }
            }
            .navigationTitle("Multiplication Tables")
            .toolbar {
                Button("Start") {
                    startGameBlock(maximumTable, numberOfQuestions)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView { _, _ in }
    }
}
