//
//  ErrorView.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 29.04.24.
//

import Foundation
import SwiftUI

struct ErrorViewModel: Identifiable {
    let id = UUID()
    let error: Error
    let additonalText: LocalizedStringKey
}


struct ErrorViewModifier: ViewModifier {

    @Binding var errorWrapper: ErrorViewModel?

    func body(content: Content) -> some View {
        content
            .sheet(item: $errorWrapper) { errorWrapper in
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text(errorWrapper.additonalText)
                }
                .onAppear {
                    logger.error(errorWrapper.error)
                }
            }
    }
}

extension View {
    func onError(_ errorWrapper: Binding<ErrorViewModel?>) -> some View {
        modifier(ErrorViewModifier(errorWrapper: errorWrapper))
    }
}

#Preview {
    Text(String("ErrorView"))
        .onError(.constant(
            ErrorViewModel(error: NSError(domain: "Err", code: 1), additonalText: "An Error was thrown"))
        )
}
