//
//  NewsFeedView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/22/25.
//

import SwiftUI

import CoreData

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    @StateObject private var bookmarkViewModel = BookmarksViewModel() // To trigger reload
    let coreDataDAO = CoreDataDAO() // Create an instance

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(viewModel.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleRowView(article: article)
                                .accessibilityIdentifier("ArticleRow_\(article.id)")
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
                                bookmarkViewModel.loadBookmarks()
                            } label: {
                                Image(systemName: coreDataDAO.isArticleBookmarked(article: article) ? "bookmark.fill" : "bookmark")
                            }
                            .tint(.accentColor)
                            .accessibilityIdentifier("BookmarkButton_\(article.id)")
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .padding(.top, 0)
                .accessibilityIdentifier("NewsFeedList")
            }
            .navigationTitle("Top Headlines")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Top Headlines")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                        .accessibilityIdentifier("NewsFeedTitle")
                }
            }
            .onAppear {
                viewModel.loadHeadlines()
                bookmarkViewModel.loadBookmarks()
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
            .accessibilityIdentifier("NewsFeedView")
        }
        .background(Color(.systemBackground)) 
    }
}

#Preview {
    NewsFeedView()
}
