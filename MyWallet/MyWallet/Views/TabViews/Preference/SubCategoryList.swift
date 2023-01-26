//
//  SubCategoryListView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 22/1/23.
//

import SwiftUI

struct SubCategoryList: View {
    var color: Color
    
    let subCategory: [SubCategoryEntity]
    
    var body: some View {
        List(subCategory) { item in
            HStack(spacing: 10) {
                CellImageView(imageName: item.wrappedImageName, color: color)
                
                Text(item.wrappedName)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
            }
        }
        .navigationTitle("Sub-Categories")
        .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}

//struct SubCategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubCategoryListView()
//    }
//}