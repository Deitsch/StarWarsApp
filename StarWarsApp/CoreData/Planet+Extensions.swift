//
//  Planets.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 24.04.24.
//

import Foundation

extension Planet {

    @discardableResult
    func internalize(from proxyObject: StarWarsApi.Planet) -> Planet {
        self.id = proxyObject.id
        self.name = proxyObject.name
        self.rotationPeriod = proxyObject.rotationPeriod
        self.orbitalPeriod = proxyObject.orbitalPeriod
        self.diameter = proxyObject.diameter
        self.climate = proxyObject.climate
        self.gravity = proxyObject.gravity
        self.terrain = proxyObject.terrain
        self.surfaceWater = proxyObject.surfaceWater
        self.population = proxyObject.population
        return self
    }
}
