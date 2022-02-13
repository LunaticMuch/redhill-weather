//
//  StatusView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 13/02/2022.
//

import SwiftUI
import DateHelper

struct StatusView: View {
    let lastMetarReport: Metar
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack {
                Text(lastMetarReport.designator)
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
            }
            .background(RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(.gray))
            .padding(.leading)
            Spacer()
            VStack {
                let updatedOnDate = Date(fromString: lastMetarReport.updatedOn, format: .isoDateTimeFull)?.toString(format: .custom("dd-MM-yyyy")) ?? ""
                let updatedOnTime = Date(fromString: lastMetarReport.updatedOn, format: .isoDateTimeFull)?.toString(format: .custom("HH:mm")) ?? ""
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
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(lastMetarReport: Metar())
    }
}
