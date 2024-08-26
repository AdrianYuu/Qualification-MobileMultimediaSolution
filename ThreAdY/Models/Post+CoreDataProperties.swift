//
//  Post+CoreDataProperties.swift
//  ThreAdY
//
//  Created by Adrian Yu on 26/08/24.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var content: String?
    @NSManaged public var contentType: String?
    @NSManaged public var uploadedAt: Date?
    @NSManaged public var user: User?

}

extension Post : Identifiable {

}
