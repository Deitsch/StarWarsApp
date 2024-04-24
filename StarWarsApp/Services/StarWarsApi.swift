//
//  StarWarsApi.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation
import CoreData

// @Obserable is only iOS17+ thus not yet usable in actual applications
class StarWarsApi: ObservableObject {

    private let dataProvider: DataProvider

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    func syncApi(context: NSManagedObjectContext) async {
        do {
            try await syncPlanets(context: context)
            try await syncPeople(context: context)
            try context.save()
        }
        catch {
            logger.error(error)
        }
    }

    // Should use #KeyPath in predicates for type safty

    private func syncPlanets(context: NSManagedObjectContext) async throws {
        let apiPlanets = try await dataProvider.loadPlanets(page: 1)
        apiPlanets.forEach { apiP in
            let pred = NSPredicate(format: "id == %@", apiP.id)
            StarWarsAppModule.Planet
                .findOrCreate(context: context, predicate: pred)
                .internalize(from: apiP)
        }
    }

    private func syncPeople(context: NSManagedObjectContext) async throws {
        let apiPeople = try await dataProvider.loadPeople(page: 1)
        apiPeople.forEach { apiP in
            let pred = NSPredicate(format: "id == %@", apiP.id)
            let p = StarWarsAppModule.Person
                .findOrCreate(context: context, predicate: pred)
                .internalize(from: apiP)

            let fr = StarWarsAppModule.Planet.fetchRequest()
            fr.predicate = pred
            do {
                let planet = try context.fetch(fr).first
                guard let planet else { return }
                p.homeworld = planet
            }
            catch {
                logger.error(error)
            }

        }
    }
}
