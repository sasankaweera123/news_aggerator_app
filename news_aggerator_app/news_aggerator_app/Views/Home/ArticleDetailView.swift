//
//  ArticleDetailView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/22/25.
//

import SwiftUI

struct ArticleDetailView: View {
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
 
