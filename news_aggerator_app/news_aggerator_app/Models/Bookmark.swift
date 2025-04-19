//
//  Bookmark.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import Foundation
import CoreData

@objc(Bookmark)
public class Bookmark: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
}

extension Bookmark {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }
}
