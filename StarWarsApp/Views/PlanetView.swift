//
//  PlanetView.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 25.04.24.
//

import SwiftUI

struct PlanetView: View {

    let planet: Planet

    var body: some View {
        Text(planet.name ?? "")
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let planet: Planet = context.fetchOneOf()
    return PlanetView(planet: planet)
}
