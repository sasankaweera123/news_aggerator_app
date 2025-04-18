//
//   LoadingView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct _LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(2)
            Text("Loading...")
        }
    }
}

#Preview {
    _LoadingView()
}
