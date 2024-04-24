//
//  DemoDataProvider.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation

class DemoDataProvider {}

extension DemoDataProvider: DataProvider {
    func loadPeople(page: Int) async throws -> [StarWarsApi.Person] {
        return [
            StarWarsApi.Person(id: "1", name: "Luke", height: "188", mass: "80", hairColor: "blond", skinColor: "fair", eyeColor: "blue", birthYear: "19BBY", gender: "male", homeworldId: "1")
        ]
    }
    
    func loadPlanets(page: Int) async throws -> [StarWarsApi.Planet] {
        return [
            StarWarsApi.Planet(id: "1", name: "Tatooine", rotationPeriod: "23", orbitalPeriod: "304", diameter: "10465", climate: "arid", gravity: "1 standard", terrain: "desert", surfaceWater: "1", population: "20000")
        ]
    }
}
