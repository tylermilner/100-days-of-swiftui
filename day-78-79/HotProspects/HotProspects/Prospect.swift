//
//  Prospect.swift
//  HotProspects
//
//  Created by Tyler Milner on 11/8/23.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveFile = "prospects.json"
    
    init() {
        people = FileManager.default.decodeFileFromDocuments(saveFile) ?? []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            let saveURL = FileManager.documentsDirectory.appendingPathComponent(saveFile)
            try? encoded.write(to: saveURL, options: [.atomic, .completeFileProtection])
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
