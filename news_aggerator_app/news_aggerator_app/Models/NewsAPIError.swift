//
//  NewsAPIError.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/19/25.
//

import Foundation

enum NewsAPIError: Error, CustomStringConvertible {
    case apiKeyMissing
    case invalidResponse
    case decodingFailed
    case network(Error)

    var description: String {
        switch self {
        case .apiKeyMissing:
            return "API Key is missing. Please provide a valid key."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Failed to decode data."
        case .network(let err):
            return "Network error: \(err.localizedDescription)"
        }
    }
}
