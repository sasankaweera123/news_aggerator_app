//
//  news_aggerator_appApp.swift
//  news_aggerator_app
//
//  Created by user270598 on 4/16/25.
//

import SwiftUI

@main
struct news_aggerator_appApp: App {
    @StateObject var bookmarksViewModel = BookmarksViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(bookmarksViewModel)
        }
    }
}
