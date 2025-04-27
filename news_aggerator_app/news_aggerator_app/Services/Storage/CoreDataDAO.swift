//
//  CoreDataDAO.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation
import CoreData

class CoreDataDAO {
    private let context = PersistenceController.shared.container.viewContext
    
    func saveBookmark(article: NewsArticle) {
        let bookmark = Bookmark(context: context)
        bookmark.id = article.id
        bookmark.title = article.title
        bookmark.desc = article.description
        bookmark.url = article.url
        bookmark.urlToImage = article.urlToImage
        bookmark.publishedAt = article.publishedAt
        bookmark.sourceName = article.source.name
        try? context.save()
    }
    
    func fetchBookmarks() -> [NewsArticle] {
        let request: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        guard let results = try? context.fetch(request) else { return [] }
        return results.map {
            NewsArticle(
                id: $0.id ?? UUID(),
                title: $0.title ?? "",
                description: $0.desc,
                url: $0.url ?? "",
                urlToImage: $0.urlToImage,
                publishedAt: $0.publishedAt ?? "",
                content: nil,
                source: NewsArticle.Source(id: nil, name: $0.sourceName ?? "Unknown")
            )
        }
    }
    
    func deleteBookmark(id: UUID) {
        let request: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        if let result = try? context.fetch(request).first {
            context.delete(result)
            try? context.save()
        }
    }
    
    func isArticleBookmarked(article: NewsArticle) -> Bool {
        let request: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", article.url) // Check by URL
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking bookmark status: \(error)")
            return false
        }
    }
    
    // Save registered user
    func saveUser(username: String, email: String, password: String) {
        let user = UserAccount(context: context)
        user.id = UUID()
        user.username = username
        user.email = email
        user.password = password
        saveContext()
    }
    
    // Fetch user by email
    func fetchUser(byEmail email: String) -> UserAccount? {
        let request: NSFetchRequest<UserAccount> = UserAccount.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return (try? context.fetch(request))?.first
    }
    
    // Verify login
    func verifyLogin(email: String, password: String) -> Bool {
        guard let user = fetchUser(byEmail: email) else { return false }
        return user.password == password
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data context: \(error.localizedDescription)")
            }
        }
    }
}
