//
//  Redhill_WeatherApp.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 28/01/2022.
//

import SwiftUI

@main
struct RedhillWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    var body: some View {
        TabView {
            AtisView()
                .tabItem {
                    Label("ATIS", systemImage: "cloud.sun.rain.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}
