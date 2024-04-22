//
//  DataProvider.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation

protocol DataProvider {
    func loadPeople(page: Int) async throws -> [Person]
    func loadPlanets(page: Int) async throws -> [Planet]
}
