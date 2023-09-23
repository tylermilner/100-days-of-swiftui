//
//  User.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/18/23.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
