//
//  FriendDetailView.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import SwiftUI

struct FriendDetailView: View {
    let friend: Friend
    let image: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if let image = image {
                    HStack {
                        Spacer()
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.8)
                        
                        Spacer()
                    }
                } else {
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
                    .frame(maxWidth: .infinity) // Centers ZStack horizontally
                }
            }
        }
        .navigationTitle(friend.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let friend = Friend(name: "John Doe")
    return FriendDetailView(friend: friend, image: nil)
}
