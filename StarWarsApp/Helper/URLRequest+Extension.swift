//
//  URLRequest+Extension.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation


extension URLRequest {
    enum HttpMethod: String {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }

    mutating func httpMethod(_ method: HttpMethod) {
        httpMethod = method.rawValue
    }
}
