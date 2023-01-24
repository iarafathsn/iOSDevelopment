//
//  CategoryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var categoryEntity: FetchedResults<CategoryEntity>
    
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
                        NavigationLink(destination: SubCategoryListView(color: ColorEMHelper.getColor(colorEntity: category.color!), subCategory: category.subcategoryArray)) {
                            
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

// MARK: Unused.
struct SubCategoryView: View {
    var catType: CategoryType
    var color: Color
    
    let subCategory: [SubCategory] = Categories.subList
    
    var body: some View {
        VStack {
            List(subCategory) { item in
                if item.parentType == catType {
                    HStack(spacing: 10) {
                        CellImageView(imageName: item.image, color: color)
                        
                        Text(item.name)
                            .minimumScaleFactor(0.5)
                            .lineLimit(2)
                    }
                }
            }
        }
        .navigationTitle("Sub-Categories")
        .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
