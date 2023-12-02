//
//  Cards.swift
//  Flashzilla
//
//  Created by Tyler Milner on 11/16/23.
//

import Foundation

@MainActor class Cards: ObservableObject {
    @Published private(set) var cards: [Card]
    private let saveFile = "Cards.json"
    
    init() {
        cards = FileManager.default.decodeFileFromDocuments(saveFile) ?? []
    }
    
    func addCard(_ card: Card) {
        cards.insert(card, at: 0)
        save()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(cards) {
            let saveURL = FileManager.documentsDirectory.appendingPathComponent(saveFile)
            try? data.write(to: saveURL, options: [.atomic, .completeFileProtection])
        }
    }
}
