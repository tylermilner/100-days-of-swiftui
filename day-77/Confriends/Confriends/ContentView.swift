//
//  ContentView.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var friends = Friends()
    
    @State private var showingAddFriendAlert = false
    @State private var name: String = ""
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            Group {
                if friends.isEmpty {
                    Text("No friends yet 😔")
                } else {
                    List {
                        ForEach(friends.friends) { friend in
                            let friendImage = friends.image(for: friend)
                            
                            NavigationLink {
                                FriendDetailView(friend: friend, image: friendImage)
                            } label: {
                                HStack {
                                    if let friendImage = friendImage {
                                        Image(uiImage: friendImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 50, maxHeight: 50)
                                    }
                                    
                                    Text(friend.name)
                                }
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
        guard image != nil else { return }
        showingAddFriendAlert = true
    }
    
    func saveFriend() {
        guard let inputImage = inputImage else { return }
        
        // TODO: Get location using LocationFetcher
        let location = Location.example
        let friend = Friend(name: name, location: location)
        friends.saveFriend(friend, image: inputImage)
        
        resetValues()
    }
    
    func resetValues() {
        name = ""
        inputImage = nil
    }
    
    func removeItems(at offsets: IndexSet) {
        friends.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

