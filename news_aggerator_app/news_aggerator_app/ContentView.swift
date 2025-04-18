//
//  ContentView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

        var body: some View {
            TabView(selection: $selectedTab) {
                TopHeadlinesView()
                    .tabItem {
                        Label("Home", systemImage: "newspaper")
                    }
                    .tag(0)

                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(1)

                BookmarksView()
                    .tabItem {
                        Label("Bookmarks", systemImage: "bookmark.fill")
                    }
                    .tag(2)
            }
        }
}

#Preview {
    ContentView()
}
