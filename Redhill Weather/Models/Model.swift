//
//  Model.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 01/02/2022.
//

import Foundation


// MARK - This struct is a real mess. It is a bit of outrageous code but the starting point, ie the JSON returned by the API,
// is bad, undocumented and frankly not even nicely modelled.

struct Metar: Decodable {
    var siteId: String
    var metar: String
    var designator: String
    var runway: String
    var updatedOn: String
    var isAutomatic: Bool
    var isCavok: Bool
    var qfe: Int
    var qnh: Int
    var temperature: Int
    var dewPoint: Int
    var visibility: Int
    var clouds: [CloudCoverage]
    var isWindVariable: Bool
    var windSpeed: Int
    var windBetweenFrom: Int
    var windDirection: Int
    var windBetweenTo: Int
    var windSpeedGust: Int

    struct CloudCoverage: Decodable {
        var type: Int = 0
        var height: Int = 0
        var cover: Int = 0
    }
    
    enum OuterKeys: String, CodingKey {
        case siteId
        case reports
    }
    
    enum ReportsKeys: String, CodingKey {
        case metarReport
    }
    
    // "Reports"."metarReport"
    enum MetarReportKeys: String, CodingKey {
        case auto, arrivalAtis, time, temperature, cloud, cavok, qnh, airfieldQfe, visibility
    }
    
    enum VisibilityKeys: String, CodingKey {
        case visibility
    }
    
    enum TemperatureKeys: String, CodingKey {
        case temperature, dewPoint
    }
    
    enum CloudKeys: String, CodingKey {
        case cloudLayer1, cloudLayer2, cloudLayer3
    }
    
    // "Reports"."metarReport"."temperature"
    enum MetarKeys: String, CodingKey {
        case cloud
    }

    enum ArrivalAtisKeys: String, CodingKey {
        case codeLetter, runway, metReportString, wind
    }
    
    enum WindKeys: String, CodingKey {
        case wind2Min
    }
    
    enum RecentWindContainer: String, CodingKey  {
        case isVrb, averageWindSpeed, averageWindDirection, minimumWindDirection, maximumWindDirection, maximumWindSpeed
    }
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let reportsContainer = try outerContainer.nestedContainer(keyedBy: ReportsKeys.self, forKey: .reports)
        self.siteId = try outerContainer.decode(String.self, forKey: .siteId)
        
        // METAR information
        let metarContainer = try reportsContainer.nestedContainer(keyedBy: MetarReportKeys.self, forKey: .metarReport)
        self.updatedOn = try metarContainer.decode(String.self, forKey: .time)
        self.isCavok = try metarContainer.decode(Bool.self, forKey: .cavok)
        self.isAutomatic = try metarContainer.decode(Bool.self, forKey: .auto)
        self.qnh = try metarContainer.decode(Int.self, forKey: .qnh)
        self.qfe = try metarContainer.decode(Int.self, forKey: .airfieldQfe)
        
        // Arrival ATIS
        let arrivalAtisContainer = try metarContainer.nestedContainer(keyedBy: ArrivalAtisKeys.self, forKey: .arrivalAtis)
        self.metar = try arrivalAtisContainer.decode(String.self, forKey: .metReportString)
        self.designator = try arrivalAtisContainer.decode(String.self, forKey: .codeLetter)
        self.runway = try arrivalAtisContainer.decode(String.self, forKey: .runway)
        
        // Temperature
        let temperatureContainer = try metarContainer.nestedContainer(keyedBy: TemperatureKeys.self, forKey: .temperature)
        self.temperature = try temperatureContainer.decode(Int.self, forKey: .temperature)
        self.dewPoint = try temperatureContainer.decode(Int.self, forKey: .dewPoint)
        
        // Visibility
        let visibilityContainer = try metarContainer.nestedContainer(keyedBy: VisibilityKeys.self, forKey: .visibility)
        self.visibility = try visibilityContainer.decode(Int.self, forKey: .visibility)
        
        // Clouds
        let cloudContainer = try metarContainer.nestedContainer(keyedBy: CloudKeys.self, forKey: .cloud)
        self.clouds = [CloudCoverage]()
        
        if let cloud1 = try? cloudContainer.decode(CloudCoverage.self, forKey: .cloudLayer1) {
            self.clouds.append(cloud1)
        }
        
        if let cloud2 = try? cloudContainer.decode(CloudCoverage.self, forKey: .cloudLayer2) {
            self.clouds.append(cloud2)
        }
        
        if let cloud3 = try? cloudContainer.decode(CloudCoverage.self, forKey: .cloudLayer3) {
            self.clouds.append(cloud3)
        }
        
        // Wind
        let windContainer = try arrivalAtisContainer.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        let recentWindContainer = try windContainer.nestedContainer(keyedBy: RecentWindContainer.self, forKey: .wind2Min)
        self.windSpeed = try recentWindContainer.decode(Int.self, forKey: .averageWindSpeed)
        self.isWindVariable = try recentWindContainer.decode(Bool.self, forKey: .isVrb)
        self.windBetweenFrom = try recentWindContainer.decode(Int.self, forKey: .minimumWindDirection)
        self.windBetweenTo = try recentWindContainer.decode(Int.self, forKey: .maximumWindDirection)
        self.windSpeedGust = try recentWindContainer.decode(Int.self, forKey: .maximumWindSpeed)
        self.windDirection = try recentWindContainer.decode(Int.self, forKey: .averageWindDirection)
    }
    
    init() {
        self.siteId = ""
        self.metar = ""
        self.designator = ""
        self.runway = ""
        self.updatedOn = ""
        self.isAutomatic = true
        self.isCavok = true
        self.qfe = 0
        self.qnh = 0
        self.temperature = 0
        self.dewPoint = 0
        self.visibility = 0
        self.clouds = []
        self.isWindVariable = false
        self.windSpeed = 0
        self.windDirection = 0
        self.windBetweenFrom = 0
        self.windBetweenTo = 0
        self.windSpeedGust = 0
    }

}



extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}
