//
//  SearchViewModel.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                loadRecentSearches()
            } else {
                searchResults = [] // Clear previous results when typing
            }
        }
    }
    @Published var searchResults: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var error: NewsAPIError?
    @Published var recentSearches: [String] = []

    private let newsAPI = NewsAPI()
    private let recentSearchesKey = "recentNewsSearches"
    private let maxRecentSearches = 5 // Limit the number of recent searches stored

    init() {
        loadRecentSearches()
    }

    func search(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResults = []
            return
        }

        isLoading = true
        error = nil
        newsAPI.searchArticles(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let articles):
                    self?.searchResults = articles
                    self?.saveRecentSearch(query: query.trimmingCharacters(in: .whitespacesAndNewlines))
                case .failure(let error):
                    self?.error = error
                    self?.searchResults = []
                }
            }
        }
    }

    private func loadRecentSearches() {
        if let savedSearches = UserDefaults.standard.array(forKey: recentSearchesKey) as? [String] {
            recentSearches = savedSearches
        } else {
            recentSearches = []
        }
    }

    private func saveRecentSearch(query: String) {
        if !recentSearches.contains(query) {
            recentSearches.insert(query, at: 0)
            if recentSearches.count > maxRecentSearches {
                recentSearches.removeLast()
            }
            UserDefaults.standard.set(recentSearches, forKey: recentSearchesKey)
        }
    }

    func clearRecentSearches() {
        recentSearches.removeAll()
        UserDefaults.standard.removeObject(forKey: recentSearchesKey)
    }
}
