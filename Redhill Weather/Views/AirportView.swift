//
//  AirportView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 06/02/2022.
//

import SwiftUI

struct AirportView: View {
    let lastMetarReport: Metar
    
    var body: some View {
        Text("AIRPORT VIEW")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.top, 9)
            .padding(.bottom, -2)
        
        HStack {
            VStack {
                Text("Runway")
                Text(lastMetarReport.runway)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            Spacer()
            VStack {
                Text("QNH \(lastMetarReport.qnh)")
                Text("QFE \(lastMetarReport.qfe)")
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6).clipShape(RoundedRectangle(cornerRadius: 5)))
       
    }
}

struct AirportView_Previews: PreviewProvider {
    static var previews: some View {
        AirportView(lastMetarReport: Metar())
    }
}
