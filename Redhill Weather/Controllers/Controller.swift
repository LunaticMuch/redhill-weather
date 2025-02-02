//
//  Controller.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 30/01/2022.
//

import Foundation

class RedhillMetar: NSObject, URLSessionDelegate, ObservableObject {
    @Published var lastMetarReport: Metar = .init()
    @Published var isRefreshing: Bool = false
    @Published var isUpdated: Bool = true
    
    override init() {
        super.init()
        loadMetar()
    }
    
    func loadMetar() {
        isRefreshing = true
        let url = URL(string: "https://serverless-wrapper-redhill-minimet.vercel.app/api/minimet")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        // prepare json data
        let json: [String: Any] = ["$type": "Miros.Models.SiteQuery, Miros.Repository.Models", "ids": ["828f98f5-8191-48f4-8a71-e48d288759d4"]]
        
        _ = try? JSONSerialization.data(withJSONObject: json)
        
        // Call the endpoint
        let configuration = URLSessionConfiguration.default
        
        // URLSession with delegate for handling certificate insecurity
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {
            data, _, error in
            if error == nil {
                // Check the data really containts data
                guard let data = data else { return }
                let decoder = JSONDecoder()
                // Check the metar can be decoded correctly
                if let decodedMetar = try? decoder.decode(Metar.self, from: data) {
                    self.lastMetarReport = decodedMetar
                    self.isRefreshing = false
                    self.isUpdated = true
                } else { self.isRefreshing = false; self.isUpdated = true; return }
            }
        }
        task.resume()
    }
    
}
