//
//  AccountCellView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 15/1/23.
//

import SwiftUI

struct AccountCellView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<Account>
    
    @State private var currency = UserDefaultHelper.shared.getCurrency().code
    
    var body: some View {
        List {
            ForEach(account) { item in
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(red: item.colorRed, green: item.colorGreen, blue: item.colorBlue, opacity: item.colorAlpha))
                        Image(systemName: item.imageName!)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    Text("\(item.name!)")
                        .font(.system(size: 24, weight: .bold))
                }
                
                Text("\(currency) \(UtilityHelper.shared.getBalanceString(balance: item.balance))")
            }
        }
        .onAppear {
            currency = UserDefaultHelper.shared.getCurrency().code
        }
    }
}

struct AccountCellView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCellView()
    }
}
