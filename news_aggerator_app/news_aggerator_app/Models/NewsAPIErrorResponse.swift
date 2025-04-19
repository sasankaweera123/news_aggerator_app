//
//  NewsAPIErrorResponse.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/19/25.
//

import Foundation

struct NewsAPIErrorResponse: Codable {
    let status: String
    let code: String
    let message: String
}
