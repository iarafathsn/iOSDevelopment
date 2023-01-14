//
//  AddAccountVM.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

class AddAccountVM: ObservableObject {
    @Published var accountName: String = "Cash"
    
    func setAccountName(name: String) -> Void {
        accountName = name
    }
}
