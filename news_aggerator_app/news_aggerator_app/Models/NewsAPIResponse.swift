//
//  NewsAPIResponse.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/19/25.
//

import Foundation

struct NewsAPIResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}
