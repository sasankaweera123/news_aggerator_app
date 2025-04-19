//
//  CategoryFilterView.swift
//  news_aggerator_app
//
//  Created by user271739 on 4/19/25.
//

import SwiftUI

struct CategoryFilterView: View {
    let categories = Category.allCases
    @Binding var selectedCategory: Category?
    var onCategorySelected: (Category) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Filter by Category")
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                            onCategorySelected(category)
                        }) {
                            Text(category.rawValue.capitalized)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedCategory == category ? .white : .primary)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CategoryFilterView(
        selectedCategory: .constant(.technology),
        onCategorySelected: { _ in }
    )
}
