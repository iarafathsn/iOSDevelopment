//
//  MyWalletApp.swift
//  MyWallet
//
//  Created by Arafat Hossain on 31/12/22.
//

import SwiftUI

@main
struct MyWalletApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var currencySetting = CurrencySetting.shared
    
    let dataController = CoreDataModel.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(currencySetting)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                Logger.i("App State: Background")
            case .inactive:
                Logger.i("App State: Inactive")
            case .active:
                Logger.i("App State: Active")
                
            @unknown default:
                Logger.i("App State: Unknown")
            }
        }
    }
}
