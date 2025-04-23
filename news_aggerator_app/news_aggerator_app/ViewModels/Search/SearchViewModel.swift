//
//  SearchViewModel.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var error: NewsAPIError?

    private let newsAPI = NewsAPI()
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Set up a publisher to observe changes to searchText
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main) // Wait 0.5 seconds after the last input
            .removeDuplicates() // Only proceed if the new value is different
            .sink { [weak self] newText in
                if !newText.isEmpty {
                    self?.searchArticles(query: newText)
                } else {
                    self?.searchResults = [] // Clear results when text field is empty
                    self?.error = nil
                }
            }
            .store(in: &cancellables)
    }

    func searchArticles(query: String) { // Modified to accept a query parameter
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        isLoading = true
        newsAPI.searchArticles(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let articles):
                    self?.searchResults = articles
                    self?.error = nil
                case .failure(let error):
                    self?.searchResults = []
                    self?.error = error
                }
            }
        }
    }
}
