//
//  FullArticleView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct FullArticleView: View {
    let article: NewsArticle
    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: article.publishedAt) else { return "" }
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(article.title)
                    .font(.title)
                    .bold()
                
                HStack {
                    if let domain = URL(string: article.url)?.host {
                        Text(domain)
                    }
                    
                    if !formattedDate.isEmpty {
                        Text(" - ")
                        Text(formattedDate)
                    }
                }
                .font(.caption)
                
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 8)
                }
                
                Text(article.content ?? article.description ?? "No content available")
                    .font(.body)
                    .padding()
                
                if let url = URL(string: article.url) {
                    Link(destination: url) {
                        HStack {
                            Text("Read full article on website")
                            Image(systemName: "arrow.up.right")
                        }
                        .padding(.top)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(URL(string: article.url)?.host ?? "Article")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FullArticleView(article: NewsArticle(
            title: "Sample News Article",
            description: "This is a sample news article description that might appear in the list view.",
            url: "https://example.com/news/sample-article",
            urlToImage: "https://example.com/image.jpg",
            publishedAt: "2023-05-15T12:34:56Z",
            content: "This is the full content of the sample news article. It contains all the details that would be shown when the user taps on an article in the list view. The content might include multiple paragraphs and other rich text elements."
        ))
    }
}
