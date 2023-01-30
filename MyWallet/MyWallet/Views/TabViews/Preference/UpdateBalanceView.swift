//
//  UpdateBalanceView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 30/1/23.
//

import SwiftUI

struct UpdateBalanceView: View {
    @EnvironmentObject var currencySetting: CurrencySetting
    @State private var balanceType = BalanceType.positive
    
    @FocusState private var isInputActive: Bool
    
    @Binding var balance: Double
    @Binding var isInitialBalance: Bool
    
    var initialBalance: Double
    var currentBalance: Double

    var body: some View {
        Form {
            Section {
                Picker("Choose transaction type", selection: $balanceType) {
                    ForEach(BalanceType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .onAppear {
                    if balance < 0 {
                        balanceType = .negative
                        balance *= -1
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    Text("\(currencySetting.currency.code)")
                        .cornerRadius(10)
                        .font(.system(size: 30, weight: .semibold))
                    
                    Spacer()
                    
                    TextField("0", value: $balance, format: .number)
                        .lineLimit(1)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(self.getAmountTextColor())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($isInputActive)
                }
            }
            
            Section("Choose the adjustment option") {
                HStack {
                    Text("Update Initial Balance")
                        .font(.system(size: 24, weight: .semibold))
                    
                    if isInitialBalance == true {
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    if isInitialBalance == false {
                        balance = initialBalance
                        isInitialBalance = true
                    }
                }
                
                Text("By updating initial balance, the initial balance value will be updated")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                HStack {
                    Text("Update Current Balance")
                        .font(.system(size: 24, weight: .semibold))
                    
                    if isInitialBalance == false {
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    if isInitialBalance == true {
                        balance = currentBalance
                        isInitialBalance = false
                    }
                }
                
                Text("If you forgot about some transaction, but the balance is changed, you can adjust the balance by this option")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Balance Option")
        .onDisappear {
            Logger.i("Balance: \(balance)")
            if balanceType == .negative {
                balance *= -1
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    Logger.i("Keyboard hide pressed")
                    isInputActive = false
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                })
            }
        }
    }
    
    private func getAmountTextColor() -> Color {
        switch balanceType {
        case .negative:
            return .red
        case .positive:
            return .green
        }
    }
}

enum BalanceType: String, CaseIterable {
    case positive = "Positive"
    case negative = "Negative"
}

//struct UpdateBalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            UpdateBalanceView()
//        }
//    }
//}
