//
//  SettingsView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 16/02/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Show QFE", isOn: .constant(false))
                } header: {
                    Text("Settings")
                }
                Section {
                    NavigationLink {
                        InfoView()
                    } label: {
                        Text("About this app")
                    }
                } header: {
                    Text("Settings")
                }
            }
        }
        .navigationTitle("App Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
