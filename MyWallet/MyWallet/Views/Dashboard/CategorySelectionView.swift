//
//  CategorySelectionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 16/1/23.
//

import SwiftUI

struct CategorySelectionView: View {
    let categoryItems: [Category] = Categories.mainList
    
    @Binding var selectedSubCategory: SubCategory?
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack {
            List(categoryItems) { item in
                HStack(spacing: 10) {
                    NavigationLink(destination: SubCategorySelectionView(catType: item.type, color: item.color, selectedSubCategory: $selectedSubCategory, isPresenting: $isPresenting)) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(item.color)
                            Image(systemName: item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                        }
                        
                        Text(item.name)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
            }
        }
        .navigationTitle("Categories")
        .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}

struct SubCategorySelectionView: View {
    var catType: CategoryType
    var color: Color
    
    @Binding var selectedSubCategory: SubCategory?
    @Binding var isPresenting: Bool
    
    let subCategory: [SubCategory] = Categories.subList
    
    var body: some View {
   
        VStack {
            List(subCategory) { item in
                if item.parentType == catType {
                    HStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(color)
                            Image(systemName: item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                        }
                        
                        Text(item.name)
                            .minimumScaleFactor(0.5)
                            .lineLimit(2)
                    }
                    .onTapGesture {
                        selectedSubCategory = item
                        isPresenting = false
                        Logger.i("Sub-Category selected: \(item.name)")
                    }
                }
            }
        }
        .navigationTitle("Sub-Categories")
        .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}
