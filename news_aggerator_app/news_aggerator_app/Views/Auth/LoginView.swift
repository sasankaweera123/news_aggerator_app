//
//  LoginView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/29/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login Here")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                    .accessibilityIdentifier("LoginTitle")

                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .accessibilityIdentifier("LoginEmailField")

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .accessibilityIdentifier("LoginPasswordField")

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("LoginErrorMessage")
                }

                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(false)
                .accessibilityIdentifier("LoginButton")

                NavigationLink(destination: RegisterView()) {
                    Text("Don't have an account? Register")
                        .foregroundColor(.secondary)
                }
                .accessibilityIdentifier("RegisterNavigationLink")

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityIdentifier("CancelButton")
                }
            }
            .alert(isPresented: $viewModel.isLoggedIn) {
                Alert(
                    title: Text("Login Successful"),
                    message: Text("You have successfully logged in."),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
            .accessibilityIdentifier("LoginView")
        }
    }
}

#Preview {
    LoginView()
}
