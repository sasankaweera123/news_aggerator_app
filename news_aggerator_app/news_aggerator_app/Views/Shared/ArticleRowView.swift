//
//  ArticleRowView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct ArticleRowView: View {
    let article: NewsArticle

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                    .accessibilityIdentifier("ArticleTitle_\(article.id)")

                if let desc = article.description {
                    Text(desc)
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("ArticleDescription_\(article.id)")
                }

                Text(article.source.name)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier("ArticleSource_\(article.id)")
            }

            Spacer()

            if let urlStr = article.urlToImage, let url = URL(string: urlStr) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipped()
                        .accessibilityIdentifier("ArticleImage_\(article.id)")
                } placeholder: {
                    Color.gray.frame(width: 80, height: 80)
                        .accessibilityIdentifier("PlaceholderImage_\(article.id)")
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemGray6))
        )
        .padding(.vertical, 4) 
        .accessibilityIdentifier("ArticleRow_\(article.id)")
    }
}

/*
 #Preview {
 ArticleRowView(article: NewsArticle(
 title: "Sample News Headline",
 description: "This is a brief summary of the article.",
 url: "https://example.com",
 urlToImage: "https://via.placeholder.com/150",
 publishedAt: "2025-04-19T03:00:00Z",
 content: "Full content of the article goes here..."
 ))
 .previewLayout(.sizeThatFits)
 .padding()
 }
 */
