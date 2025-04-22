//
//  BookmarksView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct BookmarksView: View {
    @StateObject private var viewModel = BookmarksViewModel()

    var body: some View {
        List(viewModel.bookmarkedArticles) { article in
            NavigationLink(destination: ArticleDetailView(article: article)) {
                ArticleRowView(article: article)
            }
        }
        .navigationTitle("Bookmarks")
        .onAppear {
            viewModel.loadBookmarks()
        }
    }
}

#Preview {
    BookmarksView()
}
