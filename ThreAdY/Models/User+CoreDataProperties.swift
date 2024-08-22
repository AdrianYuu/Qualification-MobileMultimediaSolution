//
//  User+CoreDataProperties.swift
//  ThreAdY
//
//  Created by Adrian Yu on 22/08/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
