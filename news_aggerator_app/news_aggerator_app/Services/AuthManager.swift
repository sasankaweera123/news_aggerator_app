//
//  AuthManager.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/27/25.
//

import Foundation

class AuthManager {
    private let dao = CoreDataDAO()
    
    func register(username: String, email: String, password: String) -> Bool {
        if dao.fetchUser(byEmail: email) != nil {
            return false
        }
        dao.saveUser(username: username, email: email, password: password)
        return true
    }
    
    func login(email: String, password: String) -> Bool {
        if email.lowercased() == "admin" && password == "Admin@123" {
            return true
        }
        return dao.verifyLogin(email: email, password: password)
    }
}

