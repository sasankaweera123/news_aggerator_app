//
//   LoadingView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(2)
            Text("Loading...")
        }
    }
}

#Preview {
    LoadingView()
}
