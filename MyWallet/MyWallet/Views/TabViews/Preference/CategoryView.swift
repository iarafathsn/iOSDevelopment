//
//  CategoryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

struct CategoryView: View {
    let categoryItems: [Category] = Categories.mainList
    
    var body: some View {
        VStack {
            List(categoryItems) { item in
                HStack(spacing: 10) {
                    NavigationLink(destination: SubCategoryView(catType: item.type)) {
                        Image(systemName: item.image)
                        Text(item.name)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
            }
        }
        .navigationTitle("Categories")
        .font(.system(size: 30, weight: .semibold, design: .rounded))
    }
}

struct SubCategoryView: View {
    var catType: CategoryType
    let subCategory: [SubCategory] = Categories.subList
    
    var body: some View {
//        let subcategoryList: [SubCategory] = Categories.subList.filter( $0.parentType == catType )
        
        VStack {
            List(subCategory) { item in
                if item.parentType == catType {
                    HStack(spacing: 10) {
                        Image(systemName: item.image)
                        Text(item.name)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
            }
        }
        .navigationTitle("Sub-Categories")
        .font(.system(size: 30, weight: .semibold, design: .rounded))
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
