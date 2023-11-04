//
//  ContentView.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddFriend = false
    
    // TODO: Remove test data
    @State private var friends = [
        Friend(name: "One"),
        Friend(name: "Two"),
        Friend(name: "Three")
    ].sorted()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(friends) { friend in
                    NavigationLink {
                        FriendDetailView(friend: friend)
                    } label: {
                        Text(friend.name)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Confriends")
            .toolbar {
                Button {
                    showingAddFriend = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddFriend) {
                AddFriendView()
            }
        }
    }
}

private extension ContentView {
    func removeItems(at offsets: IndexSet) {
        friends.remove(atOffsets: offsets)
        // TODO: Remove friend from persistent storage
    }
}

#Preview {
    ContentView()
}

