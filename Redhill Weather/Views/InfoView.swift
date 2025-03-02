//
//  InfoView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 10/02/2022.
//

import SwiftUI

let instagramURL = URL(string: "https://instagram.com/theyarestefano")!
let linkedinURL = URL(string: "https://linkedin.com/in/stefanocislaghi")!
let githubURL = URL(string: "https://github.com/lunaticmuch")!

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Redhill Aerodrome ATIS")
                    .font(.system(size: 28, weight: .bold))
                VStack(spacing: 20) {
                    Text("Redhill Aerodrome ATIS app if a free application which ATIS and Metar information for Redhill Airport (EGKR) in Surrey, UK.")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(UIColor.systemGray6)))
                Text("Disclaimer")
                    .padding(.top, 40)
                    .font(.system(size: 20, weight: .bold))
                VStack(spacing: 20) {
                    Text("This application is freely based on the data provided the weather station at the airport.)")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(UIColor.systemGray6)))
                Spacer()
                Divider()
                HStack {
                    Link(destination: instagramURL, label: {
                        Image("instagram")
                            .foregroundColor(Color(UIColor.systemGray))
                            .padding()
                    })
                    Link(destination: linkedinURL, label: {
                        Image("linkedin")
                            .foregroundColor(Color(UIColor.systemGray))
                            .padding()
                    })
                    Link(destination: githubURL, label: {
                        Image("github")
                            .foregroundColor(Color(UIColor.systemGray))
                            .padding()
                    })
                }
                .padding(.bottom, 30)
            }.padding()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
