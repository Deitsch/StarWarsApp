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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    logger.info("\(Bundle.version)")
                    logger.info("\(Config.api_url.url!)")
                }
        }
    }
}
