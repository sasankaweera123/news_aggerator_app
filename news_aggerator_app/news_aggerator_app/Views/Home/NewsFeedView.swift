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

/*struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    @StateObject private var bookmarkViewModel = BookmarksViewModel() // To trigger reload
    let coreDataDAO = CoreDataDAO() // Create an instance

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        VStack(alignment: .leading, spacing: 2) { 
                            /*Text(article.title)
                                .font(.headline.weight(.semibold)) // Slightly smaller and bolder
                                .lineLimit(2) // To prevent very long titles from taking too much space*/
                            ArticleRowView(article: article)
                        }
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
                    .listRowSeparator(.automatic) // Keep default separators for clarity
                }
            }
            .navigationTitle("Top Headlines")
            .navigationBarTitleDisplayMode(.inline) // Centers the title
            .toolbarBackground(.hidden, for: .navigationBar)
            .onAppear {
                viewModel.loadHeadlines()
                bookmarkViewModel.loadBookmarks() // Load bookmarks on appear
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}*/

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    @StateObject private var bookmarkViewModel = BookmarksViewModel() // To trigger reload
    let coreDataDAO = CoreDataDAO() // Create an instance

    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // Reduce unnecessary spacing
                List {
                    ForEach(viewModel.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleRowView(article: article)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                if coreDataDAO.isArticleBookmarked(article: article) {
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
                        .listRowSeparator(.hidden) // Hides separators for cleaner look
                    }
                    .listRowBackground(Color.clear) // Removes list row background
                }
                .scrollContentBackground(.hidden) // Removes the default background for the List
                .padding(.top, 0) // Removes extra top padding
            }
            .navigationTitle("Top Headlines")
            .navigationBarTitleDisplayMode(.inline) // Keeps title compact
            .onAppear {
                viewModel.loadHeadlines()
                bookmarkViewModel.loadBookmarks() // Load bookmarks on appear
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
        .background(Color(.systemBackground)) // Ensures a clean background
    }
}

#Preview {
    NewsFeedView()
}
