//
//  Redhill_WeatherApp.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 28/01/2022.
//

import SwiftUI

@main
struct Redhill_WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun.rain.fill")
                }
            
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle.fill")
                }
        }
    }
}
