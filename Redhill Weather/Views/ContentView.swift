//
//  ContentView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 28/01/2022.
//

import DateHelper
import RefreshableScrollView
import SwiftUI

struct ContentView: View {
    @ObservedObject var metar = RedhillMetar()
    @Environment(\.scenePhase) var scenePhase

    // @State var isUpdated: Bool = true

    // MARK: This function checks whether the metar was issued more than 30 mins from now

    func checkRefresh() {
        print("Checking")
        let now = Date()
        if let updatedOnDate = Date(fromString: metar.lastMetarReport.updatedOn, format: .isoDateTimeFull) {
            if (now - updatedOnDate) > 1800 {
                metar.isUpdated = false
            } else {
                metar.isUpdated = true
            }
        }
    }

    var body: some View {
        RefreshableScrollView(refreshing: $metar.isRefreshing, action: { metar.loadMetar() }) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        let updatedOnTime = Date(fromString: metar.lastMetarReport.updatedOn, format: .isoDateTimeFull)?.toString(format: .custom("HH:mm")) ?? ""
                        Text("Redhill Airport")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("ATIS information at \(updatedOnTime)").fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        if metar.isUpdated == false {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color(UIColor.systemYellow))
                        }
                    }
                }

                .padding()
                StatusView(lastMetarReport: metar.lastMetarReport)
                // AirportView(lastMetarReport: metar.lastMetarReport)
                ObservationView(lastMetarReport: metar.lastMetarReport)
                MetarView(lastMetarReport: metar.lastMetarReport)
            }
        }.padding()
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .inactive:
                    return
                case .active:
                    checkRefresh()
                case .background:
                    return
                @unknown default:
                    return
                }
            }
        // End of RefreshableScrollView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
