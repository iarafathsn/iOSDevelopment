//
//  AddTextField.swift
//  MyWallet
//
//  Created by Arafat Hossain on 30/1/23.
//

import SwiftUI

struct AddTextField: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isInputActive: Bool
    
    @Binding var text: String
    var title: String?
    
    var body: some View {
        VStack {
            if let title = self.title {
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
            }
            
            TextField("", text: $text)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(.system(size: 24, weight: .semibold))
                .focused($isInputActive)
                .onSubmit {
                    Logger.i("Finished")
                    dismiss()
                }
            
            Spacer()
        }
        .onAppear {
            isInputActive = true
        }
    }
}

struct AddTextField_Previews: PreviewProvider {
    @State static var value = "Title"
    
    static var previews: some View {
        AddTextField(text: $value, title: "Title")
    }
}
