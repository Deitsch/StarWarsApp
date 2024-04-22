//
//  SettingsView.swift
//  StarWarsApp
//
//  Created by Simon Deutsch on 22.04.24.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {
        NavigationStack {
            List {
                cell(label: "Version", value: Bundle.version)
            }
            .navigationTitle("Settings")
        }
    }

    @ViewBuilder
    private func cell(label: String, value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    SettingsView()
}
