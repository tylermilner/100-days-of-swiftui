//
//  AddFriendView.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import SwiftUI

struct AddFriendView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Button("Select an image") {
                    showingImagePicker = true
                }
                
                if let image = inputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        saveFriend()
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
}

private extension AddFriendView {
    func saveFriend() {
        let friend = Friend(name: name)
        // TODO: Save friend to persistent storage
    }
}

#Preview {
    AddFriendView()
}
