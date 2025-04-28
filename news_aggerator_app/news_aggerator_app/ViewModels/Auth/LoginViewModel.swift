//
//  LoginViewModel.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoggedIn = false 

    private let authManager = AuthManager()

    func login() {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter both email and password."
            return
        }

        if authManager.login(email: email, password: password) {
            isLoggedIn = true
            errorMessage = nil
            print("Login successful for \(email)")
        } else {
            errorMessage = "Invalid email or password."
            isLoggedIn = false
            print("Login failed for \(email)")
        }
    }
}
