//
//  RegisterView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/29/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Register Here")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                    .accessibilityIdentifier("RegisterTitle")
                
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.words)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .accessibilityIdentifier("RegisterUsernameField")
                
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .accessibilityIdentifier("RegisterEmailField")
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .accessibilityIdentifier("RegisterPasswordField")
                
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .accessibilityIdentifier("RegisterConfirmPasswordField")
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("RegisterErrorMessage")
                }
                
                Button(action: {
                    viewModel.register()
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(false)
                .accessibilityIdentifier("RegisterButton")
                
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
            .alert(isPresented: $viewModel.registrationSuccess) {
                Alert(
                    title: Text("Registration Successful"),
                    message: Text("Your account has been created."),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
            .accessibilityIdentifier("RegisterView")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview{
    RegisterView()
}
