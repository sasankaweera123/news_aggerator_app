//
//  Category.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var apiValue: String {
        self.rawValue
    }
}
