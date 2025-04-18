//
//  FullArticleView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct FullArticleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Article Title").font(.title).bold()
                Text("Author Name - Date").font(.caption)
                Text("Article content goes here...").padding()
            }
            .padding()
        }
    }
}

#Preview {
    FullArticleView()
}
