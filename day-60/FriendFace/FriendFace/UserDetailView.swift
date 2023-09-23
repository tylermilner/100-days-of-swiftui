//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/22/23.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        GeometryReader{ geometry in
            Form {
                ZStack {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(maxWidth: geometry.size.width * 0.6)
                    
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.3)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity) // Allows ZStack to be centered horizontally
                
                Section("Info") {
                    VStack(alignment: .leading) {
                        Text("\(user.isActive ? "Active Now" : "Inactive")")
                        Text("\(user.age) years old")
                        Text("Works for \(user.company)")
                        Text(user.email)
                        Text(user.address)
                    }
                }
                
                Section("Tags") {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                ZStack {
                                    Capsule()
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 100)
                                    
                                    Text(tag)
                                        .foregroundColor(.white)
                                        .fixedSize()
                                }
                            }
                        }
                    }
                }
                
                Section("About") {
                    VStack(alignment: .leading) {
                        Text(user.about)
                        Text("Member since \(user.registered.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline)
                    }
                }
                
                Section("Friends") {
                    ForEach(user.friends) {
                        Text($0.name)
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let user = User(id: UUID(), isActive: false, name: "Test", age: 21, company: "Test Company", email: "test@example.com", address: "555 Test", about: "This is some information about the test user.", registered: Date(timeIntervalSince1970: 1695434825), tags: ["Test User", "Cool"], friends: [
        Friend(id: UUID(), name: "Friend 1"),
        Friend(id: UUID(), name: "Friend 2")
    ])
    return UserDetailView(user: user)
}
