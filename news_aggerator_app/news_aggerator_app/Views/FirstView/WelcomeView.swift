//
//  WelcomeView.swift
//  news_aggerator_app
//
//  Created by user271739 on 5/3/25.
//

import SwiftUI

struct WelcomeView: View {
    var onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image("AppWelcomeImage")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding()

            Text("Welcome to News Aggregator App")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()

            Text("Your one-stop hub for the latest headlines!")
                .font(.body)
                .padding()
            
            Button(action: {
                onDismiss() // Navigate to ContentView
            }) {
                HStack {
                    Text("Continue")
                        .foregroundColor(.white)
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black)
                .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}
