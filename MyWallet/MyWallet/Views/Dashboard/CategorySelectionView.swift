//
//  CategorySelectionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 16/1/23.
//

import SwiftUI

struct CategorySelectionView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var categoryEntity: FetchedResults<CategoryEntity>
    
    let categoryItems: [Category] = Categories.mainList
    
    @Binding var selectedSubCategory: SubCategoryEntity?
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack {
            if categoryEntity.count == 0 {
                Button("Refresh Category") {
                    UtilityHelper.shared.initilizeCategory()
                }
                
                Spacer()
            }
            else {
                List(categoryEntity) { category in
                    HStack(spacing: 10) {
                        NavigationLink(destination: SubCategorySelectionListView(color: ColorEMHelper.getColor(colorEntity: category.color!),
                                                                                 subCategory: category.subcategoryArray,
                                                                                 selectedSubCategory: $selectedSubCategory, isPresenting: $isPresenting)) {
                            
                            CellImageView(imageName: category.wrappedImageName, color: ColorEMHelper.getColor(colorEntity: category.color!))

                            Text(category.wrappedName)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
        .navigationTitle("Categories")
        .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}

struct SubCategorySelectionListView: View {
    var color: Color
    let subCategory: [SubCategoryEntity]
    
    @Binding var selectedSubCategory: SubCategoryEntity?
    @Binding var isPresenting: Bool
    
    var body: some View {
        List(subCategory) { item in
            HStack(spacing: 10) {
                CellImageView(imageName: item.wrappedImageName, color: color)
                
                Text(item.wrappedName)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
            }
            .onTapGesture {
                selectedSubCategory = item
                isPresenting = false
                Logger.i("Sub-Category selected: \(item.wrappedName)")
            }
        }
        .navigationTitle("Sub-Categories")
        .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}
