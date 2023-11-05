//
//  Friends.swift
//  Confriends
//
//  Created by Tyler Milner on 11/4/23.
//

import Foundation
import UIKit

class Friends: ObservableObject {
    private static let documentsDirectory = FileManager.documentsDirectory
    private static let friendsJSONSavePath = documentsDirectory.appendingPathComponent("friends").appendingPathExtension("json")
    
    @Published private(set) var friends: [Friend]
    
    var isEmpty: Bool {
        friends.isEmpty
    }
    
    init() {
        do {
            let data = try Data(contentsOf: Self.friendsJSONSavePath)
            friends = try JSONDecoder().decode([Friend].self, from: data)
            friends.sort()
        } catch {
            print("Error loading friends JSON: \(error.localizedDescription)")
            print("No such file error is expected until some friends have been saved")
            friends = []
        }
    }
    
    func image(for friend: Friend) -> UIImage? {
        do {
            let imagePath = imageURL(for: friend)
            let jpegData = try Data(contentsOf: imagePath)
            return UIImage(data: jpegData)
        } catch {
            print("Error retrieving image: \(error)")
            return nil
        }
    }
    
    func saveFriend(_ friend: Friend, image: UIImage) {
        friends.append(friend)
        friends.sort()
        
        // Save image data to disk
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
                let savePath = imageURL(for: friend)
                try jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
                print("Image saved successfully: \(savePath)")
            } catch {
                print("Error saving image: \(error.localizedDescription)")
            }
        }
        
        // Save friends to disk
        saveFriendsJSONToDisk()
    }
    
    func remove(atOffsets offsets: IndexSet) {
        // Get list of friends that will be removed
        let friendsToRemove = friends.filter { friend in
            if let index = friends.firstIndex(of: friend) {
                return offsets.contains(index)
            }
            return false
        }
        
        // Remove image data from disk
        for friend in friendsToRemove {
            do {
                let imageURL = imageURL(for: friend)
                try FileManager.default.removeItem(at: imageURL)
                print("Removed image: \(imageURL)")
            } catch {
                print("Error removing image: \(error.localizedDescription)")
            }
        }
        
        // Remove friends from the working array
        friends.remove(atOffsets: offsets)
        
        // Save friends to disk
        saveFriendsJSONToDisk()
    }
}

private extension Friends {
    func imageURL(for friend: Friend) -> URL {
        return Self.documentsDirectory
            .appendingPathComponent(friend.photoUUID.uuidString)
            .appendingPathExtension("jpeg")
    }
    
    func saveFriendsJSONToDisk() {
        do {
            let savePath = Self.friendsJSONSavePath
            
            let data = try JSONEncoder().encode(friends)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Friends JSON saved successfully: \(savePath)")
        } catch {
            print("Error saving friends JSON: \(error.localizedDescription)")
        }
    }
}
