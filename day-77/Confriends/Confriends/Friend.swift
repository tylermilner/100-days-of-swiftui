//
//  Friend.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import Foundation

struct Friend: Codable, Identifiable, Comparable {
    var id: UUID = UUID()
    let name: String
    var photoUUID: UUID = UUID()
    let location: Location?
    
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        lhs.name < rhs.name
    }
}
