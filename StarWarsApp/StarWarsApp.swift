//
//  StarWarsApp.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 21.04.24.
//

import SwiftUI
import Logging

let logger = Logger(label: "io.deitsch.starwarsapp")

@main
struct StarWarsApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var api = StarWarsApi(dataProvider: RemoteDataProvider())
    @State private var errorWrapper: ErrorViewModel?

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .task {
                    do {
                        try await api.syncApi(context: persistenceController.container.newBackgroundContext())
                    }
                    catch {
                        if let error = error as? StarWarsApi.ApiError {
                            errorWrapper = ErrorViewModel(error: error, additonalText: error.errorText)
                        }
                        else {
                            errorWrapper = ErrorViewModel(error: error, additonalText: "An Error occured")
                        }
                    }
                }
                .onError($errorWrapper)
        }
    }
}
