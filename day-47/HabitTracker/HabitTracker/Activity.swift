//
//  Activity.swift
//  HabitTracker
//
//  Created by Tyler Milner on 9/10/23.
//

import Foundation

struct Activity: Identifiable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var completionCount = 0
}
