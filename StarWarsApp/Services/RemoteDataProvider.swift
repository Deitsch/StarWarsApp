//
//  RemoteDataProvider.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation

class RemoteDataProvider {

    private enum Endpoint: String {
        case people
        case planets
    }

    private let urlSession: URLSession
    private let apiURL: URL

    init() {
        urlSession = URLSession(configuration: .default)
        guard let apiURL = Config.apiUrl.url else {
            fatalError("config url always has to be configured")
        }
        self.apiURL = apiURL
    }

    private func buildRequest(method: URLRequest.HttpMethod, endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: apiURL.appending(path: endpoint.rawValue))
        request.httpMethod(method)
        return request
    }
}

extension RemoteDataProvider: DataProvider {
    func loadPeople(page: Int) async throws -> [StarWarsApi.Person] {
        let personRequest = buildRequest(method: .GET, endpoint: .people)
        return try await loadPaginatedType(page: page, request: personRequest)
    }
    
    func loadPlanets(page: Int) async throws -> [StarWarsApi.Planet] {
        let planetRequest = buildRequest(method: .GET, endpoint: .planets)
        return try await loadPaginatedType(page: page, request: planetRequest)
    }

    private func loadPaginatedType<T: Codable>(page: Int, request: URLRequest) async throws -> [T] {
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw StarWarsApi.ApiError.internalServerError
            }
            guard httpResponse.statusCode == 200 else {
                // could be handled more detailed, diff status codes, message mapping ...
                throw StarWarsApi.ApiError.someError
            }
            do {
                let decodedData = try JSONDecoder().decode(StarWarsApi.PaginationWrapper<T>.self, from: data)
                return decodedData.results
            } catch {
                throw StarWarsApi.ApiError.decodingError(error)
            }
        }
        catch {
            // https://developer.apple.com/documentation/foundation/1508628-url_loading_system_error_codes/nsurlerrorsecureconnectionfailed
            if (error as NSError).code == NSURLErrorSecureConnectionFailed {
                throw StarWarsApi.ApiError.sslError
            }
            throw error
        }
    }
}
