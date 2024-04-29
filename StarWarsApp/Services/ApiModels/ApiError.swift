//
//  ApiError.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 24.04.24.
//

import Foundation
import SwiftUI

extension StarWarsApi {
    enum ApiError: Error {
        case internalServerError
        case sslError
        case someError
        case decodingError(Error)
        case unknown

        var errorText: LocalizedStringKey {
            switch self {
            case .internalServerError: "Internal Sever Eror"
            case .sslError: "SSL Error, check if API certificate is valid"
            case .someError: "Some Error, improve error handling"
            case .decodingError: "Failed to decode response"
            case .unknown: "An unknown error occured"
            }
        }
    }
}
