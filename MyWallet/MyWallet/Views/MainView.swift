//
//  ContentView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 31/12/22.
//

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) private var manageObjectContext
    
    var body: some View {
        TabView {
            DashboardView(vm: DashboardViewModel(context: manageObjectContext))
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            ChartView(vm: ChartViewModel(context: manageObjectContext))
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Chart")
                }
            RecordListView(vm: RecordListViewModel(context: manageObjectContext))
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Records")
                }
            StatView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Statistics")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .accentColor(.indigo)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, CoreDataModel.shared.container.viewContext)
    }
}
