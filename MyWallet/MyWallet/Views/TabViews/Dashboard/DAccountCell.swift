//
//  DAccountCell.swift
//  MyWallet
//
//  Created by Arafat Hossain on 19/1/23.
//

import SwiftUI

struct DAccountCell: View {
    let account: AccountEntity
    
    @State private var currency = UserDefaultHelper.shared.getCurrency().code
    @State private var color: Color = .red
    
    var body: some View {
        HStack {
            CellImageView(imageName: account.wrappedImageName, color: color)
            
            VStack {
                Text("\(account.wrappedName)")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(currency) \(UtilityHelper.shared.getBalanceString(balance: account.balance))")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear {
            currency = UserDefaultHelper.shared.getCurrency().code
            color = ColorEMHelper.getColor(colorEntity: account.color!)
            Logger.i("Dashboard - Account Cell Appear")
        }
    }
}
