//
//  ItemListCell.swift
//  MyWallet
//
//  Created by Arafat Hossain on 19/1/23.
//

import SwiftUI

struct ItemListCell: View {
    let recordModel: RecordModel
    
    var body: some View {
        VStack {
            HStack {
                CellImageView(imageName: UtilityHelper.shared.getRecordImageName(recordModel: recordModel),
                              color: UtilityHelper.shared.getRecordColor(recordModel: recordModel))
                
                VStack {
                    Text(UtilityHelper.shared.getRecordTitle(recordModel: recordModel))
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(recordModel.account.wrappedName)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if recordModel.note != nil {
                        Text(recordModel.note ?? "")
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                VStack {
                    if recordModel.type == AddType.transfer.rawValue {
                        Text("\(UtilityHelper.shared.getBalanceString(balance: recordModel.amount))")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    else if recordModel.type == AddType.expense.rawValue {
                        Text("-\(UtilityHelper.shared.getBalanceString(balance: recordModel.amount))")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    else {
                        Text("+\(UtilityHelper.shared.getBalanceString(balance: recordModel.amount))")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    Text("\(UtilityHelper.shared.getDateOnly(date: recordModel.date))")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("\(UtilityHelper.shared.getTimeOnly(date: recordModel.date))")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

//struct ItemListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemListCell()
//    }
//}
