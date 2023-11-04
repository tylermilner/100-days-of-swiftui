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
            let imagePath = Self.documentsDirectory
                .appendingPathComponent(friend.photoUUID.uuidString)
                .appendingPathExtension("jpeg")
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
                let savePath = Self.documentsDirectory
                    .appendingPathComponent(friend.photoUUID.uuidString)
                    .appendingPathExtension("jpeg")
                try jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
                print("Image saved successfully: \(savePath)")
            } catch {
                print("Error saving image: \(error.localizedDescription)")
            }
        }
        
        // Save friends JSON to disk
        do {
            let savePath = Self.friendsJSONSavePath
            
            let data = try JSONEncoder().encode(friends)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Friends JSON saved successfully: \(savePath)")
        } catch {
            print("Error saving friends JSON: \(error.localizedDescription)")
        }
    }
    
    func remove(atOffsets offsets: IndexSet) {
        friends.remove(atOffsets: offsets)
        
        // TODO: Remove friend and image from persistent storage
    }
}
