//
//  MetarView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 06/02/2022.
//

import SwiftUI

struct MetarView: View {
    let lastMetarReport: Metar

    var body: some View {
         Text("FULL METAR")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.top, 9)
            .padding(.bottom, -2)
        
        HStack(alignment: .center) {
            Spacer()
            Text(lastMetarReport.metar)
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        .background(Color(UIColor.systemGray6).clipShape(RoundedRectangle(cornerRadius: 5)))
        Spacer()
    }
}

struct MetarView_Previews: PreviewProvider {
    static var previews: some View {
        MetarView(lastMetarReport: Metar())
    }
}
