//
//  MyWalletApp.swift
//  MyWallet
//
//  Created by Arafat Hossain on 31/12/22.
//

import SwiftUI

@main
struct MyWalletApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
