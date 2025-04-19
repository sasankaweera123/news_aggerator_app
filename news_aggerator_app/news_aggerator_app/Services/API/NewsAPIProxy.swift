//
//  NewsAPIProxy.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

class NewsAPIProxy: APIClient {
    private let api = NewsAPI()
    private var cache: [NewsArticle]?

    func fetchTopHeadlines(country: String?, category: String?, sources: String?, query: String?, pageSize: Int?, page: Int?, completion: @escaping (Result<[NewsArticle], NewsAPIError>) -> Void) {
        if let cached = cache {
            completion(.success(cached))
        } else {
            api.fetchTopHeadlines(country: country, category: category, sources: sources, query: query, pageSize: pageSize, page: page) { [weak self] result in
                if case let .success(articles) = result {
                    self?.cache = articles
                }
                completion(result)
            }
        }
    }

    func searchArticles(query: String, completion: @escaping (Result<[NewsArticle], NewsAPIError>) -> Void) {
        api.searchArticles(query: query, completion: completion)
    }

    func fetchSources(category: String?, language: String?, country: String?, completion: @escaping (Result<[NewsSource], NewsAPIError>) -> Void) {
        api.fetchSources(category: category, language: language, country: country, completion: completion)
    }
}
