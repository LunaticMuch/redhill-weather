//
//  Model.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 01/02/2022.
//

import Foundation

struct RedhillAtis: Decodable {
    var site: String
    var metar: String
    var designator: String
    var runway: String
    var updatedOn: String
//    var isAutomatic: Bool
//    var isCavok: Bool
    var qfe: Int
    var qnh: Int
//    var temperature: Int
//    var dewPoint: Int
//    var visibility: Int
//    var clouds: [CloudCoverage]
//    var isWindVariable: Bool
//    var windSpeed: Int
//    var windBetweenFrom: Int
//    var windDirection: Int
//    var windBetweenTo: Int
//    var windSpeedGust: Int
//    var weather: String
//
//    struct CloudCoverage: Decodable {
//        var type: Int = 0
//        var height: Int = 0
//        var cover: Int = 0
//    }

    init() {
        self.site = ""
        self.metar = ""
        self.designator = ""
        self.runway = ""
        self.updatedOn = ""
//        self.isAutomatic = true
//        self.isCavok = true
        self.qfe = 0
        self.qnh = 0
//        self.temperature = 0
//        self.dewPoint = 0
//        self.visibility = 0
//        self.clouds = []
//        self.isWindVariable = false
//        self.windSpeed = 0
//        self.windDirection = 0
//        self.windBetweenFrom = 0
//        self.windBetweenTo = 0
//        self.windSpeedGust = 0
//        self.weather = ""
    }
}
