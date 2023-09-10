//
//  Activities.swift
//  HabitTracker
//
//  Created by Tyler Milner on 9/10/23.
//

import Foundation

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet {
            do {
                let data = try JSONEncoder().encode(activities)
                UserDefaults.standard.set(data, forKey: storageKey)
            } catch {
                fatalError("Unable to encode activities")
            }
        }
    }
    private let storageKey = "activities"
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            activities = []
            return
        }
        
        do {
            let activities = try JSONDecoder().decode([Activity].self, from: data)
            self.activities = activities
        } catch {
            fatalError("Unable to decode activies")
        }
    }
}
