//
//  ContentView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 31/12/22.
//

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            ChartView()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Chart")
                }
            AddEntryView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add")
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
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
