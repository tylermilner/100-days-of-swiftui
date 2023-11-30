//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Tyler Milner on 11/25/23.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites.json"
    
    init() {
        resorts = FileManager.default.decodeFileFromDocuments(saveKey) ?? []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        guard let data = try? JSONEncoder().encode(resorts) else { return }
        let saveURL = FileManager.documentsDirectory.appendingPathComponent(saveKey)
        try? data.write(to: saveURL, options: [.atomic, .completeFileProtection])
    }
}
