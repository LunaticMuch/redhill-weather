//
//  AtisViewModel.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 16/02/2025.
//

import Foundation

@Observable
class AtisViewModel {
    var current: RedhillAtis = .init()

    func fetchRedhillAtis() async throws {
        let url = URL(string: "http://localhost:3000/api/v2/minimet")!
        let (data, _) = try await URLSession.shared.data(from: url)
        current = try JSONDecoder().decode(RedhillAtis.self, from: data)
    }
}
