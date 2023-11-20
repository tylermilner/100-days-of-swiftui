//
//  DiceRolls.swift
//  DiceRoller
//
//  Created by Tyler Milner on 11/18/23.
//

import Foundation

@MainActor class DiceRolls: ObservableObject {
    @Published private(set) var rolls: [DiceRoll]
    
    private let saveFile = "rolls.json"
    
    var lastRoll: DiceRoll? {
        rolls.last
    }
    
    init() {
        rolls = FileManager.default.decodeFileFromDocuments(saveFile) ?? []
    }
    
    func add(_ roll: DiceRoll) {
        rolls.append(roll)
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(rolls) {
            let saveURL = FileManager.documentsDirectory.appendingPathComponent(saveFile)
            try? data.write(to: saveURL, options: [.atomic, .completeFileProtection])
        }
    }
}
