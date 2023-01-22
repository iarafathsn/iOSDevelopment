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
                            ZStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(ColorEMHelper.getColor(colorEntity: category.color!))
                                Image(systemName: category.wrappedImgaeName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                            }

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
    
//    var body: some View {
//        VStack {
//            List(categoryItems) { item in
//                HStack(spacing: 10) {
//                    NavigationLink(destination: SubCategorySelectionView(catType: item.type, color: item.color, selectedSubCategory: $selectedSubCategory, isPresenting: $isPresenting)) {
//                        ZStack {
//                            Circle()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(item.color)
//                            Image(systemName: item.image)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 20)
//                        }
//
//                        Text(item.name)
//                            .minimumScaleFactor(0.5)
//                            .lineLimit(1)
//                    }
//                }
//            }
//        }
//        .navigationTitle("Categories")
//        .font(.system(size: 24, weight: .semibold, design: .rounded))
//    }
}

struct SubCategorySelectionListView: View {
    var color: Color
    let subCategory: [SubCategoryEntity]
    
    @Binding var selectedSubCategory: SubCategoryEntity?
    @Binding var isPresenting: Bool
    
    var body: some View {
        List(subCategory) { item in
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(color)
                    Image(systemName: item.wrappedImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                
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
