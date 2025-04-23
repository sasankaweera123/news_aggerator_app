//
//  BookmarksViewModel.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

import Foundation

class BookmarksViewModel: ObservableObject {
    private let dao = CoreDataDAO()

    @Published var bookmarkedArticles: [NewsArticle] = []
    
    init() {
            loadBookmarks()
        }
    
    func loadBookmarks() {
        bookmarkedArticles = dao.fetchBookmarks()
    }

    func removeBookmark(id: UUID) {
        dao.deleteBookmark(id: id)
        loadBookmarks()
    }
}
