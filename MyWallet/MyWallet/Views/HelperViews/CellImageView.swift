//
//  CellImageView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 24/1/23.
//

import SwiftUI

struct CellImageView: View {
    let imageName: String
    let color: Color
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .padding(10)
            .background(color)
            .cornerRadius(10)
    }
}

struct CellImageView_Previews: PreviewProvider {
    static var previews: some View {
        CellImageView(imageName: "triangle", color: .red)
    }
}
