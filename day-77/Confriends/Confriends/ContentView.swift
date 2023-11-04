//
//  ContentView.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddFriendAlert = false
    @State private var name: String = ""
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var friends: [Friend] = [].sorted()
    
    var body: some View {
        NavigationView {
            Group {
                if friends.isEmpty {
                    Text("No friends yet 😔")
                } else {
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
                }
            }
            .navigationTitle("Confriends")
            .toolbar {
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .alert("Add Friend", isPresented: $showingAddFriendAlert) {
                TextField("Name", text: $name)
                
                Button("Cancel", role: .cancel) {
                    resetValues()
                }
                Button("Save") {
                    saveFriend()
                }
            } message: {
                Text("Enter friend's name")
            }
            .onChange(of: inputImage, perform: imageSelected)
        }
    }
}

private extension ContentView {
    func imageSelected(_ image: UIImage?) {
        guard let image = image else { return }
        showingAddFriendAlert = true
    }
    
    func saveFriend() {
        let friend = Friend(name: name)
        
        // TODO: Save friend to persistent storage
        friends.append(friend)
        
        resetValues()
    }
    
    func resetValues() {
        name = ""
        inputImage = nil
    }
    
    func removeItems(at offsets: IndexSet) {
        friends.remove(atOffsets: offsets)
        // TODO: Remove friend from persistent storage
    }
}

#Preview {
    ContentView()
}

