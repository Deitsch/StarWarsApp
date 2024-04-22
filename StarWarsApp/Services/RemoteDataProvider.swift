//
//  RemoteDataProvider.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation

class RemoteDataProvider {

    enum RemoteEndpoint: String {
        case people
        case planets
    }

    private let urlSession: URLSession
    private let apiURL: URL

    init() {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
        guard let apiURL = Config.apiUrl.url else {
            fatalError("config url always has to be configured")
        }
        self.apiURL = apiURL
    }

    private func buildRequest(method: URLRequest.HttpMethod, endpoint: RemoteEndpoint) -> URLRequest {
        var request = URLRequest(url: apiURL.appending(path: endpoint.rawValue))
        request.httpMethod(method)
        return request
    }
}

extension RemoteDataProvider: DataProvider {
    func loadPeople(page: Int) async throws -> [Person] {
        let personRequest = buildRequest(method: .GET, endpoint: .people)
        let (data, response) = try await urlSession.data(for: personRequest)
        // TODO
        // parse errors
        // parse data
    }
    
    func loadPlanets(page: Int) async throws -> [Planet] {
        let personRequest = buildRequest(method: .GET, endpoint: .planets)
        let (data, response) = try await urlSession.data(for: personRequest)
        // TODO
        // parse errors
        // parse data
    }
}
