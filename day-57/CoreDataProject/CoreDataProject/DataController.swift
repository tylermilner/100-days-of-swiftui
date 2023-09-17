//
//  DataController.swift
//  CoreDataProject
//
//  Created by Tyler Milner on 9/17/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // Create container from xcdatamodeld
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        // Load the data
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
