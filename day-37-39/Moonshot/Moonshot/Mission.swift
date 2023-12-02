//
//  Mission.swift
//  Moonshot
//
//  Created by Tyler Milner on 8/27/23.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var longFormattedLaunchDate: String {
        launchDate?.formatted(date: .long, time: .omitted) ?? "N/A"
    }
}
