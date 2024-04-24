//
//  Person.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 24.04.24.
//

import Foundation

extension StarWarsApi {

    struct Person: Codable {
        let id: String
        let name: String
        let height: String
        let mass: String
        let hairColor: String
        let skinColor: String
        let eyeColor: String
        let birthYear: String
        let gender: String
        let homeworldId: String

        init(id: String, name: String, height: String, mass: String, hairColor: String, skinColor: String, eyeColor: String, birthYear: String, gender: String, homeworldId: String) {
            self.id = id
            self.name = name
            self.height = height
            self.mass = mass
            self.hairColor = hairColor
            self.skinColor = skinColor
            self.eyeColor = eyeColor
            self.birthYear = birthYear
            self.gender = gender
            self.homeworldId = homeworldId
        }

        public init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
            id = try rootContainer.decode(URL.self, forKey: .id).lastPathComponent
            name = try rootContainer.decode(String.self, forKey: .name)
            height = try rootContainer.decode(String.self, forKey: .height)
            mass = try rootContainer.decode(String.self, forKey: .mass)
            hairColor = try rootContainer.decode(String.self, forKey: .hairColor)
            skinColor = try rootContainer.decode(String.self, forKey: .skinColor)
            eyeColor = try rootContainer.decode(String.self, forKey: .eyeColor)
            birthYear = try rootContainer.decode(String.self, forKey: .birthYear)
            gender = try rootContainer.decode(String.self, forKey: .gender)
            homeworldId = try rootContainer.decode(URL.self, forKey: .homeworld).lastPathComponent
        }

        public func encode(to encoder: Encoder) throws {
            // didn't implement encoable, wouldnt properly
            // actual API usually you write back and forth
        }

        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case id = "url"
            case name = "name"
            case height = "height"
            case mass = "mass"
            case hairColor = "hair_color"
            case skinColor = "skin_color"
            case eyeColor = "eye_color"
            case birthYear = "birth_year"
            case gender = "gender"
            case homeworld = "homeworld"
        }
    }
}
