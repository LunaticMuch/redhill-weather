//
//  ObservationView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 06/02/2022.
//

import SwiftUI

struct ObservationView: View {
    
    let lastMetarReport: Metar
    
    var body: some View {
        Text("OBSERVATION")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.top, 9)
            .padding(.bottom, -2)
        VStack {
            HStack {
                Text("Wind")
                Spacer()
                Text("\(lastMetarReport.windDirection)° at \(lastMetarReport.windSpeed) knots")
            }
            if lastMetarReport.windSpeed+10 < lastMetarReport.windSpeedGust {
                HStack {
                    Spacer()
                    Text("gusting \(lastMetarReport.windSpeedGust) knots")
                }
            }
            if lastMetarReport.windBetweenFrom != lastMetarReport.windDirection {
                HStack {
                    Spacer()
                    Text("varying \(lastMetarReport.windBetweenFrom)° and \(lastMetarReport.windBetweenTo)°")
                }
            }
            Divider()
            HStack {
                Text("Visibility")
                Spacer()
                Text("\(lastMetarReport.visibility) m")
            }
            Divider()
                // MARK: This code smells, refactor is required. `ForEach` is the best thing that shuold be used in SwiftUI, but it requires the struct to conform to `Identifiable` or `Hashable`
            if !lastMetarReport.clouds.isEmpty {
                VStack {
                    if let layer1 = lastMetarReport.clouds[safe: 0] {
                        HStack {
                            Text(cloudCoverage(layer1.cover))
                            Spacer()
                            Text("@ \(layer1.height) ft")
                        }
                    }
                    if let layer2 = lastMetarReport.clouds[safe: 1] {
                        Divider()
                        HStack {
                            Text(cloudCoverage(layer2.cover))
                            Spacer()
                            Text("@ \(layer2.height) ft")
                        }
                    }
                    if let layer3 = lastMetarReport.clouds[safe: 2] {
                        Divider()
                        HStack {
                            Text(cloudCoverage(layer3.cover))
                            Spacer()
                            Text("@ \(layer3.height) ft")
                        }
                    }
                }
            } else { HStack {
                Spacer()
                Text("No Significant Clouds").padding()
                Spacer()
            }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6).clipShape(RoundedRectangle(cornerRadius: 5)))
    }
}

struct ObservationView_Previews: PreviewProvider {
    static var previews: some View {
        ObservationView(lastMetarReport: Metar())
    }
}
