//
//  CategoryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

struct CategoryList: View {
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
                        NavigationLink(destination: SubCategoryList(color: ColorEMHelper.getColor(colorEntity: category.color!), subCategory: category.subcategoryArray)) {
                            
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

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
