//
//  AccountCellView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 15/1/23.
//

import SwiftUI

struct DAccountView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<Account>
    
    @State private var currency = UserDefaultHelper.shared.getCurrency().code
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(account) { item in
//                    NavigationLink(destination: EditAccountView(account: item)) {
//                        DAccountCell(account: item)
//                    }
//                }
//            }
//        }
        
        List {
            ForEach(account) { item in
                NavigationLink(destination: EditAccountView(account: item)) {
                    DAccountCell(account: item)
                }
            }
        }
        
//        List {
//            ForEach(account) { item in
//                HStack {
//                    ZStack {
//                        Circle()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(Color(red: item.colorRed, green: item.colorGreen, blue: item.colorBlue, opacity: item.colorAlpha))
//                        Image(systemName: item.imageName!)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 20)
//                    }
//
//                    VStack {
//                        Text("\(item.name!)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity, alignment: .leading)
////                            .padding(.all)
////                            .border(Color.gray.opacity(0.5))
//
//                        Text("\(currency) \(UtilityHelper.shared.getBalanceString(balance: item.balance))")
//                            .font(.title2)
//                            .frame(maxWidth: .infinity, alignment: .leading)
////                            .padding(.all)
////                            .border(Color.gray.opacity(0.5))
//                    }
//                    .padding(10)
//                }
//            }
//        }
//        .onAppear {
//            currency = UserDefaultHelper.shared.getCurrency().code
//        }
    }
}

struct AccountCellView_Previews: PreviewProvider {
    static var previews: some View {
        DAccountView()
    }
}
