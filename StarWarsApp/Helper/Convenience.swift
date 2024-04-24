//
//  Convenience.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 21.04.24.
//

import SwiftUI
import Logging
import CoreData

extension Logger {
    func error(_ error: Error) {
        self.error("\(error.localizedDescription)")
    }
    func error(_ error: NSError) {
        self.error("Domain: \(error.domain), Code: \(error.code), UserInfo: \(error.userInfo)")
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Bundle {
    static var version: String {
        let dictionary = Self.main.infoDictionary
        let version = dictionary?["CFBundleShortVersionString"] as? String
        let build = dictionary?["CFBundleVersion"] as? String
        return "\(version ?? "noBundleShortVersion") (\(build ?? "noBundleVersion"))"
    }
}

extension NSManagedObject {
    static func findOrCreate(context: NSManagedObjectContext, predicate: NSPredicate) -> Self {
        let fr = fetchRequest()
        fr.predicate = predicate
        guard let result = try? context.fetch(fr),
              let object = result.first as? Self else {
//            logger.info("Created new \(Self.self) object (not found for predicate \(predicate))")
            return Self(context: context)
        }
        if result.count > 1 {
            let message = "Mulitple matching \(Self.self) found for predicate \(predicate)"
            logger.warning("\(message)")
            assertionFailure(message)
        }
//        logger.info("Found \(Self.self) for predicate \(predicate)")
        return object
    }
}
