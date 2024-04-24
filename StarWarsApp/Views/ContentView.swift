//
//  ContentView.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 21.04.24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
                .toolbarBackground(.visible, for: .tabBar)
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
                .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
