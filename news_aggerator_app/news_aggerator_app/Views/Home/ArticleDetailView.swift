//
//  ArticleDetailView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/22/25.
//
 
import SwiftUI

struct ArticleDetailView: View {
    let article: NewsArticle
    @StateObject private var bookmarkViewModel = BookmarksViewModel()
    private let coreDataDAO = CoreDataDAO()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(article.title)
                        .font(Font.custom("Poppins", size: 22).weight(.bold))
                        .accessibilityIdentifier("ArticleTitle_\(article.id)")
                    
                    Spacer()
                    
                    Button {
                        handleBookmark()
                    } label: {
                        Image(systemName: coreDataDAO.isArticleBookmarked(article: article) ? "bookmark.fill" : "bookmark")
                            .font(.title2)
                            .accessibilityIdentifier("BookmarkButton_\(article.id)")
                    }
                }
                
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .accessibilityIdentifier("ArticleImage_\(article.id)")
                    } placeholder: {
                        ProgressView()
                            .accessibilityIdentifier("LoadingImageIndicator_\(article.id)")
                    }
                }

                if let desc = article.description {
                    Text(desc)
                        .font(Font.custom("Poppins", size: 16))
                        .multilineTextAlignment(.leading)
                        .accessibilityIdentifier("ArticleDescription_\(article.id)")
                }

                if let content = article.content {
                    Text(content)
                        .font(Font.custom("Poppins", size: 14))
                        .multilineTextAlignment(.leading)
                        .accessibilityIdentifier("ArticleContent_\(article.id)")
                }

                Spacer(minLength: 20)

                Text("Source: \(article.source.name)")
                    .font(Font.custom("Poppins", size: 12).weight(.bold))
                    .foregroundColor(.gray)
                    .accessibilityIdentifier("ArticleSource_\(article.id)")

                Link("Read Full Article", destination: URL(string: article.url)!)
                    .font(Font.custom("Poppins", size: 16).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .accessibilityIdentifier("ReadFullArticleButton_\(article.id)")
            }
            .padding()
            .accessibilityIdentifier("ArticleDetailView")
        }
    }
    
    private func handleBookmark() {
        if coreDataDAO.isArticleBookmarked(article: article) {
            if let bookmarkedArticle = bookmarkViewModel.bookmarkedArticles.first(where: { $0.url == article.url }) {
                coreDataDAO.deleteBookmark(id: bookmarkedArticle.id)
            }
        } else {
            coreDataDAO.saveBookmark(article: article)
        }
        bookmarkViewModel.loadBookmarks()
    }
}
