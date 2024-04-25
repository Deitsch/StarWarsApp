//
//  Route.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 25.04.24.
//

import SwiftUI

enum StarWarsRoute: Route {
    case someThing
}

class RouteFactory {
    @ViewBuilder
    static func viewForStarWarsRoute(_ route: StarWarsRoute) -> some View {
        switch route {
        case .someThing: Text("something")
        }
    }
}
