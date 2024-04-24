//
//  ApiError.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 24.04.24.
//

import Foundation

extension StarWarsApi {
    enum ApiError: Error {
        case internalServerError
        case someError
        case decodingError(Error)
        case unknown
    }
}
