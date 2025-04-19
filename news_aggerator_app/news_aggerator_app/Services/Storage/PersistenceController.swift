//
//  PersistenceController.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/19/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "NewsModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData failed: \(error.localizedDescription)")
            }
        }
    }
}
