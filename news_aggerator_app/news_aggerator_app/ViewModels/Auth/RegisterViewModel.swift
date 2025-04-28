//
//  RegisterViewModel.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String?
    @Published var registrationSuccess = false

    private let authManager = AuthManager()

    func register() {
        if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill in all fields."
            return
        }

        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email address."
            return
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }

        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters long."
            return
        }

        if authManager.register(username: username, email: email, password: password) {
            registrationSuccess = true
            errorMessage = nil
            print("Registration successful for \(email)")
        } else {
            errorMessage = "Email address already exists."
            registrationSuccess = false
            print("Registration failed for \(email)")
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
