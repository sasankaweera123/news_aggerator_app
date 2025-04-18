//
//  CategoryFilterView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct CategoryFilterView: View {
    let categories = ["Technology", "Sports", "Business", "Health"]
    @State private var selectedCategory = "All"
    
    var body: some View {
        VStack {
            Text("Select Category").font(.headline)
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

#Preview {
    CategoryFilterView()
}
