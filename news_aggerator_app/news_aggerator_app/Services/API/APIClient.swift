//
//  APIClient.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

protocol APIClient {
    func fetchTopHeadlines(
        country: String?, category: String?, sources: String?, query: String?, pageSize: Int?, page: Int?,
        completion: @escaping (Result<[NewsArticle], NewsAPIError>) -> Void
    )
    func searchArticles(query: String, completion: @escaping (Result<[NewsArticle], NewsAPIError>) -> Void)
    func fetchSources(category: String?, language: String?, country: String?, completion: @escaping (Result<[NewsSource], NewsAPIError>) -> Void)
}
