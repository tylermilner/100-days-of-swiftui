//
//  Friend.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/18/23.
//

import Foundation

struct Friend: Decodable, Identifiable {
    let id: UUID
    let name: String
}
