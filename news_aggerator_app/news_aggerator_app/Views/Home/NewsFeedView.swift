//
//  NewsFeedView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/22/25.
//

import SwiftUI

struct NewsFeedView: View {
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
}

#Preview {
    NewsFeedView()
}
