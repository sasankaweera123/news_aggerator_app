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
            NewsFeedView()  
                    .tabItem {
                        Label("Home", systemImage: "newspaper")
                    }
            NavigationView {
                SearchView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
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
