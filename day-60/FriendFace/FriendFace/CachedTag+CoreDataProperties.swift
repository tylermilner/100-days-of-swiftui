//
//  CachedTag+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/23/23.
//
//

import Foundation
import CoreData


extension CachedTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedTag> {
        return NSFetchRequest<CachedTag>(entityName: "CachedTag")
    }

    @NSManaged public var stringValue: String?
    @NSManaged public var user: NSSet?

}

// MARK: Generated accessors for user
extension CachedTag {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CachedTag : Identifiable {

}
