//
//  NewsFeedView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/22/25.
//

import SwiftUI

/*struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    ArticleRowView(article: article)
                }
            }
            .navigationTitle("Top Headlines")
            .onAppear {
                viewModel.loadHeadlines()
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
} */

import CoreData

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    @StateObject private var bookmarkViewModel = BookmarksViewModel() // To trigger reload
    let coreDataDAO = CoreDataDAO() // Create an instance

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        ArticleRowView(article: article)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            if coreDataDAO.isArticleBookmarked(article: article) {
                                // Find the bookmark by URL and delete by ID
                                if let bookmarkedArticle = bookmarkViewModel.bookmarkedArticles.first(where: { $0.url == article.url }) {
                                    coreDataDAO.deleteBookmark(id: bookmarkedArticle.id)
                                }
                            } else {
                                coreDataDAO.saveBookmark(article: article)
                            }
                            bookmarkViewModel.loadBookmarks() // Reload bookmarks in the other tab
                        } label: {
                            Image(systemName: coreDataDAO.isArticleBookmarked(article: article) ? "bookmark.fill" : "bookmark")
                        }
                        .tint(.accentColor)
                    }
                }
            }
            .navigationTitle("Top Headlines")
            .onAppear {
                viewModel.loadHeadlines()
                bookmarkViewModel.loadBookmarks() // Load bookmarks on appear
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}


#Preview {
    NewsFeedView()
}
