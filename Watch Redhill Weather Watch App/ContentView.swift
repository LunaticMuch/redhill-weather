//
//  ContentView.swift
//  Watch Redhill Weather Watch App
//
//  Created by Stefano Cislaghi on 27/03/2025.
//

import SwiftUI

struct WatchInfoBox: View {
    let label: String
    let info: String

    var body: some View {
        VStack {
            Text(label)
            Text(info).font(.largeTitle)
        }
    }
        
}

struct ContentView: View {
    @Environment(AtisViewModel.self) var atis

    var body: some View {
        ScrollView {
            Grid {
                GridRow {
                    WatchInfoBox(label: "Info", info: atis.current.designator)
                    WatchInfoBox(label: "Runway", info: atis.current.runway)
                }
                .padding()
                GridRow {
                    WatchInfoBox(label: "QNH", info: String(atis.current.qnh))
                }
                .padding(.horizontal)
            }
            .padding()
            .task {
                try? await atis.fetchRedhillAtis()
            }
            .refreshable {
                try? await atis.fetchRedhillAtis()
            }
        }
    }

}

#Preview {
    ContentView()
        .environment(AtisViewModel())
}
