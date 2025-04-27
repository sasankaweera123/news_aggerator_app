//
//  User.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/27/25.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID = UUID()
    let username: String
    let email: String
    let password: String
}

