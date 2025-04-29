//
//  BookmarksView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct BookmarksView: View {
    @StateObject var viewModel = BookmarksViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bookmarkedArticles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        ArticleRowView(article: article)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.removeBookmark(id: article.id)
                        } label: {
                            Image(systemName: "bookmark.slash.fill")
                        }
                    }
                }
                .onDelete(perform: deleteBookmark)
            }
            .navigationTitle("Bookmarks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Bookmarks")
                        .font(.system(size: 24, weight: .bold))                         .foregroundColor(.primary)
                }
            }
            .onAppear {
                viewModel.loadBookmarks()
            }
            .overlay {
                if viewModel.bookmarkedArticles.isEmpty {
                    Text("No bookmarked articles yet.")
                        .foregroundColor(.gray)
                }
            }
        }
    }

    func deleteBookmark(at offsets: IndexSet) {
        offsets.forEach { index in
            let articleToRemove = viewModel.bookmarkedArticles[index]
            viewModel.removeBookmark(id: articleToRemove.id)
        }
    }
}

#Preview {
    BookmarksView()
}
