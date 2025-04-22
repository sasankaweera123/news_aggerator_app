//
//  NewsFeedViewModel.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation
import Combine

class NewsFeedViewModel: ObservableObject {
    private let apiClient: APIClient = NewsAPIProxy()
    private let filterStrategy: NewsFilterStrategy = LatestNewsStrategy()

    @Published var articles: [NewsArticle] = []
    @Published var error: ErrorWrapper?

    func loadHeadlines(category: String? = nil) {
        apiClient.fetchTopHeadlines(country: "us", category: category, sources: nil, query: nil, pageSize: 20, page: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = self.filterStrategy.filter(articles)
                case .failure(let error):
                    self.error = ErrorWrapper(message: error.description)
                }
            }
        }
    }
}

