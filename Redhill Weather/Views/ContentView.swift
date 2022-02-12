//
//  ContentView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 28/01/2022.
//

import DateHelper
import SwiftUI

struct ContentView: View {
    @StateObject var metar = RedhillMetar()
    @Environment(\.scenePhase) var scenePhase

    @State var isUpdated: Bool = true

    // MARK: This function checks whether the metar was issued more than 30 mins from now
    func checkRefresh() {
        print("Checking")
        let now = Date()
        if let updatedOnDate = Date(fromString: metar.lastMetarReport.updatedOn, format: .isoDateTimeFull) {
            if (now - updatedOnDate) > 1800 {
                isUpdated = false
            } else {
                isUpdated = true
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Redhill Airport")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("ATIS information").fontWeight(.bold)
                    }
                    Spacer()
                    Button {
                        metar.loadMetar(); isUpdated = true
                    } label: {
                        if isUpdated == true {
                            Image(systemName: "arrow.triangle.2.circlepath.circle")
                                .resizable()
                                .scaledToFill() // add if you need
                                .frame(width: 30.0, height: 30.0) // as per your requirement
                                .clipped()
                                .foregroundColor(Color(UIColor.systemGray3))
                        } else {
                            Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
                                .resizable()
                                .scaledToFill() // add if you need
                                .frame(width: 30.0, height: 30.0) // as per your requirement
                                .clipped()
                                .foregroundColor(Color(UIColor.systemYellow))
                        }
                    }
                }
                .padding()
                HStack(alignment: .center, spacing: 10) {
                    HStack {
                        Text(metar.lastMetarReport.designator)
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(.gray))
                    .padding(.leading)
                    Spacer()
                    VStack {
                        let updatedOnDate = Date(fromString: metar.lastMetarReport.updatedOn, format: .isoDateTimeFull)?.toString(format: .custom("dd-MM-yyyy")) ?? ""
                        let updatedOnTime = Date(fromString: metar.lastMetarReport.updatedOn, format: .isoDateTimeFull)?.toString(format: .custom("HH:mm")) ?? ""
                        Text("Updated on")
                            .font(.caption)
                        Text(updatedOnTime)
                            .font(.headline)
                        Text(updatedOnDate)
                            .font(.caption2)
                    }.padding()

                    // MARK: https://stackoverflow.com/a/67087129/1320351
                }
                .padding(.horizontal)
                .background(Color(UIColor.systemGray6).clipShape(RoundedRectangle(cornerRadius: 5)))
                AirportView(lastMetarReport: metar.lastMetarReport)
                ObservationView(lastMetarReport: metar.lastMetarReport)
                MetarView(lastMetarReport: metar.lastMetarReport)
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
            // End of scroll view
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
