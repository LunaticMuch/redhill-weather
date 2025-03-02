//
//  ATISView.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 16/02/2025.
//

import SwiftUI
import DateHelper

struct AtisView: View {
    @State private var atis = AtisViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        let updatedOnTime = Date(fromString: atis.current.updatedOn, format: .isoDateTimeFull)?
                            .toString(format: .custom("HH:mm")) ?? ""
                        Text("Redhill Airport")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("ATIS information at \(updatedOnTime)").fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding()
                ZStack {
                    Color.gray.opacity(0.2)
                    VStack {
                        Text("Information").font(.title)
                        Spacer()
                        Text(atis.current.designator).font(.system(size: 54, weight: .bold))
                    }
                    .padding()
                }
                .compositingGroup()
                .cornerRadius(10)
                .padding(.horizontal)
                ZStack {
                    Color.gray.opacity(0.2)
                    VStack {
                        Text("Runway").font(.title)
                        Spacer()
                        Text(atis.current.runway).font(.system(size: 54, weight: .bold))
                    }
                    .padding()
                }
                .compositingGroup()
                .cornerRadius(10)
                .padding(.horizontal)
                ZStack {
                    Color.gray.opacity(0.2)
                    VStack {
                    Text("QNH").font(.title)
                    Spacer()
                    Text(String(atis.current.qnh)).font(.system(size: 54, weight: .bold))
                }
                .padding()}
                .compositingGroup()
                .cornerRadius(10)
                .padding(.horizontal)
                ZStack {
                    Color.gray.opacity(0.2)
                    VStack {
                    Text("Last Metar").font(.title)
                    Spacer()
                    Text(atis.current.metar).font(.title3)
                    }
                    .padding()
                }
                .compositingGroup()
                .cornerRadius(10)
                .padding(.horizontal)

            }
        }
        .navigationTitle("Current ATIS")
        .task {
            try? await atis.fetchRedhillAtis()
        }
        .refreshable {
            try? await atis.fetchRedhillAtis()
        }
    }
}

#Preview {
    AtisView()
}
