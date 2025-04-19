//
//  TopHeadlinesViewModel.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import Foundation

class TopHeadlinesViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var isLoading = false
    @Published var error: NewsAPIError?
    
    private let newsAPI = NewsAPI()
    
    func fetchTopHeadlines() {
        isLoading = true
        newsAPI.fetchTopHeadlines { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let articles):
                    self?.articles = articles
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
