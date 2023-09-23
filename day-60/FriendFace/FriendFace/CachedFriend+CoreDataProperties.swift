//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/23/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: NSSet?

}

// MARK: Generated accessors for user
extension CachedFriend {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}

// MARK: - Custom Additions

extension CachedFriend {
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    convenience init(friend: Friend, moc: NSManagedObjectContext) {
        self.init(context: moc)
        self.id = friend.id
        self.name = friend.name
    }
}
