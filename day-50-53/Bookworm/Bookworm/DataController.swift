//
//  DataController.swift
//  Bookworm
//
//  Created by Tyler Milner on 9/16/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // Create container from Bookworm.xcdatamodeld
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        // Load the data
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
