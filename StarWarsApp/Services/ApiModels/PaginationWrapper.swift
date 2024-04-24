//
//  PaginationWrapper.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 24.04.24.
//

import Foundation

extension StarWarsApi {
    struct PaginationWrapper<T: Codable>: Codable {
        let count: Int
        let next: URL?
        let previous: URL?
        let result: [T]
    }
}
