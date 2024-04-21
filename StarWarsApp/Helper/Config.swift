//
//  Config.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 21.04.24.
//

import Foundation

enum Config: String {
    case api_url = "API_URL"
}

extension Config {
    var string: String? {
        return Bundle.main.object(forInfoDictionaryKey: self.rawValue) as? String
    }

    var url: URL? {
        return string.map { URL(string: $0) } ?? nil
    }
}
