//
//  DataController.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/23/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // Create persistent container from xcdatamodel
    let container = NSPersistentContainer(name: "FriendFace")
    
    init() {
        // Load data from the persistent storage
        container.loadPersistentStores { description, error in
            if let error = error {
                debugPrint("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
