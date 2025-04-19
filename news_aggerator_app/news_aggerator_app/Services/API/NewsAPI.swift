//
//  NewsAPI.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

class NewsAPI {
    private let apiKey = "YOUR_API_KEY"
    private let baseURL = "https://newsapi.org/v2"

    func fetchTopHeadlines(
        country: String? = "us",
        category: String? = nil,
        sources: String? = nil,
        query: String? = nil,
        pageSize: Int? = 20,
        page: Int? = 1,
        completion: @escaping (Result<[NewsArticle], NewsAPIError>) -> Void
    ) {
        var components = URLComponents(string: "\(baseURL)/top-headlines")
        var queryItems = [URLQueryItem(name: "apiKey", value: apiKey)]

        if sources != nil {
            queryItems.append(URLQueryItem(name: "sources", value: sources))
        } else {
            if let country = country {
                queryItems.append(URLQueryItem(name: "country", value: country))
            }
            if let category = category {
                queryItems.append(URLQueryItem(name: "category", value: category))
            }
        }

        if let query = query {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        if let pageSize = pageSize {
            queryItems.append(URLQueryItem(name: "pageSize", value: String(pageSize)))
        }
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }

        components?.queryItems = queryItems
        fetchArticles(from: components, completion: completion)
    }

    func searchArticles(query: String, completion: @escaping (Result<[NewsArticle], NewsAPIError>) -> Void) {
        var components = URLComponents(string: "\(baseURL)/everything")
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "q", value: query)
        ]
        fetchArticles(from: components, completion: completion)
    }

    func fetchSources(
        category: String? = nil,
        language: String? = nil,
        country: String? = nil,
        completion: @escaping (Result<[NewsSource], NewsAPIError>) -> Void
    ) {
        var components = URLComponents(string: "\(baseURL)/top-headlines/sources")
        var queryItems = [URLQueryItem(name: "apiKey", value: apiKey)]

        if let category = category {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        if let language = language {
            queryItems.append(URLQueryItem(name: "language", value: language))
        }
        if let country = country {
            queryItems.append(URLQueryItem(name: "country", value: country))
        }

        components?.queryItems = queryItems
        guard let url = components?.url else {
            completion(.failure(.invalidResponse))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.network(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            if let apiError = try? JSONDecoder().decode(NewsAPIErrorResponse.self, from: data), apiError.status == "error" {
                if apiError.code == "apiKeyMissing" {
                    completion(.failure(.apiKeyMissing))
                } else {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            do {
                let decoded = try JSONDecoder().decode(SourceResponse.self, from: data)
                completion(.success(decoded.sources))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }

    private func fetchArticles(from components: URLComponents?, completion: @escaping (Result<[NewsArticle], NewsAPIError>) -> Void) {
        guard let url = components?.url else {
            completion(.failure(.invalidResponse))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.network(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            if let apiError = try? JSONDecoder().decode(NewsAPIErrorResponse.self, from: data), apiError.status == "error" {
                if apiError.code == "apiKeyMissing" {
                    completion(.failure(.apiKeyMissing))
                } else {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            do {
                let decoded = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
                completion(.success(decoded.articles))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
