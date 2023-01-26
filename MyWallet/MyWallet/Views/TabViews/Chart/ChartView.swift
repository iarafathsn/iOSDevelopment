//
//  ChartView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct ChartView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var transactionResult: FetchedResults<TransactionEntity>
    
    private let chartHelper = ChartHelper()
    
    @State private var currency = UserDefaultHelper.shared.getCurrency().code
    
    var body: some View {
        if transactionResult.count == 0 {
            ZStack {
                Circle()
                    .frame(width: 400, height: 400)
                    .foregroundColor(.orange)
                Text("No records found")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        else {
            VStack(spacing: 10) {
                if chartHelper.isExpenseRecords(transactions: transactionResult) {
                    PieChart(title: "Expenses", pieItems: chartHelper.pieItems, formatter: {value in String(format: "\(currency) %.2f", value)})
                }
            }
            .onAppear {
                currency = UserDefaultHelper.shared.getCurrency().code
            }
            .padding(10)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
