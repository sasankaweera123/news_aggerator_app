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
                TextField("Search the newses here", text: $viewModel.searchText)
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
                    .onSubmit {
                        viewModel.search(query: viewModel.searchText)
                    }

                if viewModel.isLoading {
                    ProgressView("Searching...")
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else if viewModel.searchResults.isEmpty && viewModel.searchText.isEmpty {
                    // Display Recent Searches
                    if !viewModel.recentSearches.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Recent Searches")
                                .font(.headline)
                                .padding(.leading)
                                .padding(.top,8)

                            ForEach(viewModel.recentSearches, id: \.self) { recentSearch in
                                Button(action: {
                                    viewModel.searchText = recentSearch
                                    viewModel.search(query: recentSearch)
                                }) {
                                    HStack {
                                        Image(systemName: "clock.fill")
                                            .foregroundColor(.gray)
                                        Text(recentSearch)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                                }
                            }

                            Button(action: {
                                viewModel.clearRecentSearches()
                            }) {
                                Text(" X Clear Recent Searches")
                                    .foregroundColor(.white)
                                    .padding(7)
                                    .background(Color.red)
                                    .cornerRadius(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.white, lineWidth: 1)
                                    )
                            }
                            .frame(width: 400)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        Spacer()
                    } else {
                        Text("No recent searches yet.")
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                } else {
                    // Display Search Results
                    List(viewModel.searchResults) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleRowView(article: article)
                        }
                    }
                }

                //Spacer() // Push content to the top
            }
            .navigationTitle("Search here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Search here")
                        .font(.system(size: 24, weight: .bold))                         .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
