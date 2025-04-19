//
//  SourceResponse.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/19/25.
//

import Foundation

struct SourceResponse: Codable {
    let status: String
    let sources: [NewsSource]
}
