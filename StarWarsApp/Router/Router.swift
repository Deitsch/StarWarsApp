//
//  Router.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import Foundation
import Combine
import SwiftUI

protocol Route: Equatable, Hashable, Codable {
    var stringRepresentation: String { get }
}

extension Route {
    var stringRepresentation: String {
       return String(describing: self).components(separatedBy: "(").first ?? ""
   }
}

class Router<T: Route>: ObservableObject {

    @Published var path = [T]()
    private var cancelable: AnyCancellable?

    init() {
        cancelable = $path.sink { self.logPath($0) }
    }

    func push(_ route: T) {
        logger.info("will go to screen: \(route)")
        path.append(route)
    }

    func unwindToRoot() {
        logger.info("will pop to root")
        path.removeLast(path.count)
    }

    func unwind() {
        logger.info("will go to back")
        guard !path.isEmpty else {
            let log = "Can't go back on an empty path -> did some path elemnts get lost?"
            logger.warning("\(log)")
            logPath(path)
            assertionFailure(log)
            return
        }
        path.removeLast()
    }

    func unwind(_ route: T) {
        guard let index = path.firstIndex(of: route) else {
            let log = "did no find \(route.stringRepresentation) in the view stack"
            logger.warning("\(log)")
            logPath(path)
            assertionFailure(log)
            return
        }
        path.removeLast(path.count - (index + 1))
    }

    private func logPath(_ path: [T]) {
        logger.info("count: \(path.count), path: \(path.map { $0.stringRepresentation }.joined(separator: ","))")
    }
}
