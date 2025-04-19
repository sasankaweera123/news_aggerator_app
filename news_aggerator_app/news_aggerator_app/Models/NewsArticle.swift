//
//  NewsArticle.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

struct NewsArticle: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}
