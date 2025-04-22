//
//  NewsArticle.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

struct NewsArticle: Identifiable, Codable {
    var id = UUID()

    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    let source: Source

    struct Source: Codable {
        let id: String?
        let name: String
    }
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String?,
        url: String,
        urlToImage: String?,
        publishedAt: String,
        content: String?,
        source: Source
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.source = source
    }

    enum CodingKeys: String, CodingKey {
        case title, description, url, urlToImage, publishedAt, content, source
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID() // local ID for SwiftUI list
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.source = try container.decode(Source.self, forKey: .source)
    }
}

