//
//  NewsSource.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/19/25.
//

import Foundation

struct NewsSource: Identifiable, Codable {
    var id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}
