//
//  BookmarkButton.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct BookmarkButton: View {
    let article: NewsArticle
    @ObservedObject var viewModel: BookmarksViewModel
    
    var body: some View {
        Button {
            if viewModel.isBookmarked(article) {
                viewModel.removeBookmark(article)
            } else {
                viewModel.addBookmark(article)
            }
        } label: {
            Image(systemName: viewModel.isBookmarked(article) ? "bookmark.fill" : "bookmark")
                .foregroundColor(viewModel.isBookmarked(article) ? .blue : .gray)
        }
    }
}

#Preview {
    BookmarkButton(article: <#NewsArticle#>, viewModel: <#BookmarksViewModel#>)
}
