//
//  ContentView.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                NewsFeedView()
            }
            .tabItem {
                Label("Headlines", systemImage: "newspaper")
            }

            NavigationView {
                BookmarksView()
            }
            .tabItem {
                Label("Bookmarks", systemImage: "bookmark")
            }
        }
    }
}

#Preview {
    ContentView()
}
