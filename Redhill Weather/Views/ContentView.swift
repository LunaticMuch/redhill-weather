//
//  ContentView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 28/01/2022.
//

import DateHelper
import SwiftUI

struct ContentView: View {
    @ObservedObject var metar = RedhillMetar()
    
    //Mark: This part of the code does not work
    @State var isUpdated: Bool = true

    private func checkRefresh() {
        let now = Date()
        if let updatedOnDate = Date(fromString: metar.lastMetarReport.updatedOn, format: .isoDateTimeFull) {
            if (now - updatedOnDate) > 1100 {
                isUpdated = false
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Redhill Metar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    metar.loadMetar()
                } label: {
                    if isUpdated == true {
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                            .resizable()
                            .scaledToFill() // add if you need
                            .frame(width: 30.0, height: 30.0) // as per your requirement
                            .clipped()
                            .foregroundColor(Color(UIColor.systemGray3))
                    }
                    else {
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
            }
            .padding(.horizontal)
            .background(Color(UIColor.systemGray6).clipShape(RoundedRectangle(cornerRadius: 5)))

            AirportView(lastMetarReport: metar.lastMetarReport)
            ObservationView(lastMetarReport: metar.lastMetarReport)
            MetarView(lastMetarReport: metar.lastMetarReport)
        }
        .padding()
        .onAppear(perform: { checkRefresh() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
