//
//  ArticleDetailView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/22/25.
//

import SwiftUI

/*struct ArticleDetailView: View {
    let article: NewsArticle

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(article.title)
                    .font(.headline)

                if let desc = article.description {
                    Text(desc)
                        .font(.subheadline)
                }

                if let content = article.content {
                    Text(content)
                        .font(.body)
                }

                Text("Source: \(article.source.name)")
                    .font(.caption)
                    .foregroundColor(.gray)

                Link("Read Full Article", destination: URL(string: article.url)!)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Detail")
    }
}*/

import CoreData

struct ArticleDetailView: View {
    let article: NewsArticle
    @StateObject private var bookmarkViewModel = BookmarksViewModel() // To trigger reload
    let coreDataDAO = CoreDataDAO() // Create an instance

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }

                HStack {
                    Text(article.title)
                        .font(.headline)
                    Spacer()
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
                            .font(.title2)
                    }
                }

                if let desc = article.description {
                    Text(desc)
                        .font(.subheadline)
                }

                if let content = article.content {
                    Text(content)
                        .font(.body)
                }

                Text("Source: \(article.source.name)")
                    .font(.caption)
                    .foregroundColor(.gray)

                Link("Read Full Article", destination: URL(string: article.url)!)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Detail")
        .toolbar {
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
        }
    }
}

/*
 #Preview {
 ArticleDetailView(article: NewsArticle(
 title: "Quantum Apocalypse Is Coming",
 description: "A quick overview of quantum threats.",
 url: "https://example.com",
 urlToImage: "https://via.placeholder.com/600x300",
 publishedAt: "2025-04-19T01:00:00Z",
 content: "This is a long-form article explaining the impact of quantum computers..."
 ))
 }
 */
 
