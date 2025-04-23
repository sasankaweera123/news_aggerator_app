//
//  SearchView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

/*
 struct SearchView: View {
 @State private var searchQuery = ""
 
 var body: some View {
 VStack {
 TextField("Search articles...", text: $searchQuery)
 .textFieldStyle(RoundedBorderTextFieldStyle())
 .padding()
 
 List {
 ForEach(1...5, id: \.self) { _ in
 NavigationLink(destination: FullArticleView()) {
 ArticleRowView()
 }
 }
 }
 }
 }
 }
 
 #Preview {
 SearchView()
 }
 */

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search News", text: $viewModel.searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)

                            if !viewModel.searchText.isEmpty {
                                Button(action: {
                                    viewModel.searchText = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                    )
                    .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView("Searching...")
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else if viewModel.searchResults.isEmpty {
                    if !viewModel.searchText.isEmpty {
                        Text("No results found.")
                            .foregroundColor(.gray)
                    } else {
                        Text("Enter a search term to find news.")
                            .foregroundColor(.gray)
                    }
                } else {
                    List(viewModel.searchResults) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleRowView(article: article)
                        }
                    }
                }
                Spacer() // Push content to the top
            }
            .navigationTitle("Search")
        }
    }
}
#Preview {
SearchView()
}
