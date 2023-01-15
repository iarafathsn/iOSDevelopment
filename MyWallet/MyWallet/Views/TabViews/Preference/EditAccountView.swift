//
//  EditAccountView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 15/1/23.
//

import SwiftUI

struct EditAccountView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var account: FetchedResults<Account>.Element
    
//    @State private var name = ""
//    @State private var
    
    var body: some View {
        Text("Hi")
    }
}
