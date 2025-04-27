//
//  UserAccount+CoreDataProperties.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/27/25.
//
//

import Foundation
import CoreData


extension UserAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAccount> {
        return NSFetchRequest<UserAccount>(entityName: "UserAccount")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension UserAccount : Identifiable {

}
