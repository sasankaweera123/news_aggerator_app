//
//  TrendingNewsStrategy.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

class TrendingNewsStrategy: NewsFilterStrategy {
    func filter(_ articles: [NewsArticle]) -> [NewsArticle] {
        return articles.shuffled()
    }
}
