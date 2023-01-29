//
//  CategoryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

struct CategoryList: View {
    @ObservedObject private var categoryVM: CategoryListViewModel
    
    init(vm: CategoryListViewModel) {
        self.categoryVM = vm
    }
    
    var body: some View {
        VStack {
            if categoryVM.categoryList.count == 0 {
                Button("Refresh Category") {
                    UtilityHelper.shared.initilizeCategory()
                }
                
                Spacer()
            }
            else {
                List {
                    ForEach(categoryVM.categoryList) { category in
                        HStack(spacing: 10) {
                            NavigationLink(destination: SubCategoryList(color: category.color, subCategory: category.subCategory)) {
                                CellImageView(imageName: category.imageName, color: category.color)

                                Text(category.name)
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                            }
                        }
                    }
//                    .onDelete(perform: deleteTransaction)
                }
            }
        }
        .navigationTitle("Categories")
        .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(vm: CategoryListViewModel(context: CoreDataModel.shared.container.viewContext))
    }
}
