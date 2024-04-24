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

    var body: some View {
        NavigationStack {
            List {
                ForEach(people) { p in
                    HStack {
                        Text(p.id ?? "") +
                        Text(" ") +
                        Text(p.name ?? "")
                        if let planet = p.homeworld {
                            Spacer()
                            Text(planet.name ?? "")
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
