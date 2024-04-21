//
//  StarWarsAppApp.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 21.04.24.
//

import SwiftUI

@main
struct StarWarsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
