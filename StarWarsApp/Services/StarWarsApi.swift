//
//  StarWarsApi.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation

// @Obserable is only iOS17+ thus not yet usable in actual applications
class StarWarsApi: ObservableObject {

    private let dataProvider: DataProvider

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    func syncApi() async {
        do {
            let res = try await dataProvider.loadPeople(page: 1)
            print(res)
        }
        catch {
            print(error)
        }
    }
}
