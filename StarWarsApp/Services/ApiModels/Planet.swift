//
//  Planet.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 24.04.24.
//

import Foundation

extension StarWarsApi {

    struct Planet: Codable {
        let id: String
        let name: String
        let rotationPeriod: String
        let orbitalPeriod: String
        let diameter: String
        let climate: String
        let gravity: String
        let terrain: String
        let surfaceWater: String
        let population: String

        init(id: String, name: String, rotationPeriod: String, orbitalPeriod: String, diameter: String, climate: String, gravity: String, terrain: String, surfaceWater: String, population: String) {
            self.id = id
            self.name = name
            self.rotationPeriod = rotationPeriod
            self.orbitalPeriod = orbitalPeriod
            self.diameter = diameter
            self.climate = climate
            self.gravity = gravity
            self.terrain = terrain
            self.surfaceWater = surfaceWater
            self.population = population
        }

        public init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try rootContainer.decode(URL.self, forKey: .id).lastPathComponent
            self.name = try rootContainer.decode(String.self, forKey: .name)
            self.rotationPeriod = try rootContainer.decode(String.self, forKey: .rotationPeriod)
            self.orbitalPeriod = try rootContainer.decode(String.self, forKey: .orbitalPeriod)
            self.diameter = try rootContainer.decode(String.self, forKey: .diameter)
            self.climate = try rootContainer.decode(String.self, forKey: .climate)
            self.gravity = try rootContainer.decode(String.self, forKey: .gravity)
            self.terrain = try rootContainer.decode(String.self, forKey: .terrain)
            self.surfaceWater = try rootContainer.decode(String.self, forKey: .surfaceWater)
            self.population = try rootContainer.decode(String.self, forKey: .population)
        }

        public func encode(to encoder: Encoder) throws {
            // didn't implement encoable, wouldnt properly
            // actual API usually you write back and forth
        }
        
        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case id = "url"
            case name = "name"
            case rotationPeriod = "rotation_period"
            case orbitalPeriod = "orbital_period"
            case diameter = "diameter"
            case climate = "climate"
            case gravity = "gravity"
            case terrain = "terrain"
            case gender = "gender"
            case surfaceWater = "surface_water"
            case population = "population"
        }
    }
}
