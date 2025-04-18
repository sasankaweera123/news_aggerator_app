//
//  BookmarksView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct BookmarksView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(1...5, id: \.self) { _ in
                    NavigationLink(destination: FullArticleView()) {
                        ArticleRowView()
                    }
                }
            }
            .navigationTitle("Bookmarks")
        }
    }
}

#Preview {
    BookmarksView()
}
