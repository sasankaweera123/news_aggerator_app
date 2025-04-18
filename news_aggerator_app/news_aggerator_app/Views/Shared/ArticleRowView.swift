//
//  ArticleRowView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct ArticleRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Article Title").font(.headline)
            Text("Short description...").font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    ArticleRowView()
}
