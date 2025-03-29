//
//  Redhill_WeatherApp.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 28/01/2022.
//

import SwiftUI

@main
struct RedhillWeatherApp: App {
    @State private var atis = AtisViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(atis)
        }
    }
}
