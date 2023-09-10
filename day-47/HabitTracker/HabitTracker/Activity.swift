//
//  Activity.swift
//  HabitTracker
//
//  Created by Tyler Milner on 9/10/23.
//

import Foundation

struct Activity: Identifiable {
    var id = UUID()
    let title: String
    let description: String
}
