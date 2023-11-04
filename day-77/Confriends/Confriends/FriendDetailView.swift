//
//  FriendDetailView.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import SwiftUI

struct FriendDetailView: View {
    let friend: Friend
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    ZStack {
                        // TODO: Show friend image
                        Circle()
                            .foregroundColor(.gray)
                            .frame(maxWidth: geometry.size.width * 0.6)
                        
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.3)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity) // Centers ZStack horizontally
                }
            }
            .navigationTitle(friend.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let friend = Friend(name: "John Doe")
    return FriendDetailView(friend: friend)
}
