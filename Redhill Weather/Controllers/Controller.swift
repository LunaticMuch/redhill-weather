//
//  Controller.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 30/01/2022.
//

import Foundation

class RedhillMetar: NSObject, URLSessionDelegate, ObservableObject {
    @Published var lastMetarReport: Metar = Metar()
    
    override init() {
        super.init()
        loadMetar()
    }
    
    func loadMetar() {
        let url = URL(string: "https://egkr-mini-metcom.ste.io:8080/api/SamosApi/GetData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json, text/plain", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IkFub255bW91cyIsIm5iZiI6MTY0MzQwMDk1OSwiZXhwIjoyMTE2NDQwOTU5LCJpYXQiOjE2NDM0MDA5NTl9.ihQXbP5ihhStUFDbvBxO0yp8WCQQd5_tpPijBNnCrOA", forHTTPHeaderField: "Authorization")
        request.setValue("https://81.2.71.178:8080/mini-met", forHTTPHeaderField: "Referer")
        
        // prepare json data
        let json: [String: Any] = ["$type": "Miros.Models.SiteQuery, Miros.Repository.Models", "ids": ["828f98f5-8191-48f4-8a71-e48d288759d4"]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        // Call the endpoint
        let configuration = URLSessionConfiguration.default
        
        // URLSession with delegate for handling certificate insecurity
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {
            data, _, error in
            if error == nil {
                print("I got some data")
                guard let data = data else { return }
                let decoder = JSONDecoder()
                self.lastMetarReport = try! decoder.decode(Metar.self, from: data)
                print(self.lastMetarReport)
                
            }
        }
        task.resume()
    }
    
    // This is required because the certificate of the mini metcom is selfsigned and not valid
    // There is an intrisic risk in using a self-signed certificate, although this risk
    // can be accepted in consideration of application and the URL request
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if challenge.protectionSpace.host == "egkr-mini-metcom.ste.io" {
                print("NON-Default Handling starting")
                let trust = challenge.protectionSpace.serverTrust!
                let credential = URLCredential(trust: trust)
                completionHandler(.useCredential, credential)
            } else {
                print("Default Handling performed")
                completionHandler(.performDefaultHandling, nil)
            }
        }
    }
}
