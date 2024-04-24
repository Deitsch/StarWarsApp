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
//        , delegate: BypassInvalidCertSessionDelegate(), delegateQueue: nil
        urlSession = URLSession(configuration: .default)
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
    func loadPeople(page: Int) async throws -> [StarWarsApi.Person] {
        let personRequest = buildRequest(method: .GET, endpoint: .people)
        return try await loadPaginatedType(page: page, request: personRequest)
    }
    
    func loadPlanets(page: Int) async throws -> [StarWarsApi.Planet] {
        let planetRequest = buildRequest(method: .GET, endpoint: .planets)
        return try await loadPaginatedType(page: page, request: planetRequest)
    }

    private func loadPaginatedType<T: Codable>(page: Int, request: URLRequest) async throws -> [T] {
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
            return decodedData.result
        } catch {
            throw StarWarsApi.ApiError.decodingError(error)
        }
    }
}

// workaround because swapi.dev does not have a valid cert since 22.04.2024
class BypassInvalidCertSessionDelegate: NSObject, URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
         // Trust the certificate even if not valid
         let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
         completionHandler(.useCredential, urlCredential)
      }
}
