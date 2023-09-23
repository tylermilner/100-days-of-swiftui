//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/23/23.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: NSSet?
    @NSManaged public var friends: NSSet?

}

// MARK: Generated accessors for tags
extension CachedUser {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: CachedTag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: CachedTag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}

// MARK: - Custom Additions

extension CachedUser {
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown About"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date(timeIntervalSince1970: 0)
    }
    
    public var tagsArray: [CachedTag] {
        let set = tags as? Set<CachedTag> ?? []
        return Array(set)
    }
    
    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return Array(set)
    }
    
    convenience init(user: User, moc: NSManagedObjectContext) {
        self.init(context: moc)
        self.id = user.id
        self.isActive = user.isActive
        self.name = user.name
        self.age = Int16(user.age)
        self.company = user.company
        self.email = user.email
        self.address = user.address
        self.about = user.about
        self.registered = user.registered
        
        let cachedTags = user.tags.map { CachedTag(stringValue: $0, moc: moc) }
        self.tags = NSSet(array: cachedTags)
        
        let cachedFriends = user.friends.map { CachedFriend(friend: $0, moc: moc) }
        self.friends = NSSet(array: cachedFriends)
    }
}
