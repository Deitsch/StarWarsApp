//
//  Person+Extension.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 24.04.24.
//

import Foundation

extension Person {

    @discardableResult
    func internalize(from proxyObject: StarWarsApi.Person) -> Person {
        self.id = proxyObject.id
        self.name = proxyObject.name
        self.height = proxyObject.height
        self.mass = proxyObject.mass
        self.hairColor = proxyObject.hairColor
        self.skinColor = proxyObject.skinColor
        self.eyeColor = proxyObject.eyeColor
        self.birthYear = proxyObject.birthYear
        self.gender = proxyObject.gender
        return self
    }
}
