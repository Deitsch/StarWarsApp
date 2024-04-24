//
//  StarWarsAppApp.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 21.04.24.
//

import SwiftUI
import Logging

let logger = Logger(label: "io.deitsch.starwarsapp")

@main
struct StarWarsAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var api = StarWarsApi(dataProvider: RemoteDataProvider())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .task {
                    await api.syncApi()
                }
        }
    }
}
