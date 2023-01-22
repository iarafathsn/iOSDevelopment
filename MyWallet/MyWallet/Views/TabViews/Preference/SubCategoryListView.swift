//
//  SubCategoryListView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 22/1/23.
//

import SwiftUI

struct SubCategoryListView: View {
    var color: Color
    
    let subCategory: [SubCategoryEntity]
    
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
