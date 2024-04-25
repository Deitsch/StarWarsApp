//
//  HomeView.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import SwiftUI

struct HomeView: View {

    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.id, order: .forward)
    ]) var people: FetchedResults<Person>

    @StateObject private var router = Router<StarWarsRoute>()

    var body: some View {
        NavigationStack {
            List {
                ForEach(people) { p in
                    if let planet = p.homeworld {
                        NavigationLink(value: planet) {
                            personView(p)
                        }
                    }
                    else {
                        personView(p)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: Planet.self, destination: { planet in
                PlanetView(planet: planet)
            })
        }
    }

    @ViewBuilder
    private func personView(_ p: Person) -> some View {
        HStack {
            Text(p.id ?? "") +
            Text(" ") +
            Text(p.name ?? "")
        }
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
