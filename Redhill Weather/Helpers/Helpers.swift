//
//  Helpers.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 06/02/2022.
//

import Foundation

func cloudCoverage(_ cover: Int) -> String {
    switch cover {
    case 1..<3: return "Few"
    case 3..<5: return "Scattered"
    case 5..<7: return "Broken"
    case 8: return "Overcast"
    default: return ""
    }
}

func decodeWeather (_ codedMetar:String) -> String {
    var decoded: String = ""
    switch codedMetar.count {
    case 5: decoded += decodeWeatherCode(codedMetar.substring(with: 0..<1)) + " "
        decoded += decodeWeatherCode(codedMetar.substring(with: 1..<3)) + " "
        decoded += decodeWeatherCode(codedMetar.substring(with: 3..<5))
    case 4: decoded += decodeWeatherCode(codedMetar.substring(with: 0..<2)) + " "
        decoded += decodeWeatherCode(codedMetar.substring(with: 2..<4))
    case 3:
        decoded += decodeWeatherCode(codedMetar.substring(with: 0..<1)) + " "
        decoded += decodeWeatherCode(codedMetar.substring(with: 1..<3))
    case 2:
        decoded += decodeWeatherCode(codedMetar.substring(with: 0..<2))
    default: decoded = ""
    }
    return decoded
}

    // The decoder of weather codes
fileprivate func decodeWeatherCode (_ code:String) -> String {
    switch code {
    case "VC": return "In the vicinity"
    case "MI": return "Shallow"
    case "PR": return "Partial"
    case "BC": return "Patches"
    case "DR": return "Low Drifting"
    case "BL": return "Blowing"
    case "SH": return "Shower"
    case "TS": return "Thunderstorm"
    case "FZ": return "Freezing"
    case "DZ": return "Drizzle"
    case "RA": return "Rain"
    case "SN": return "Snow"
    case "SG": return "Snow Grains"
    case "IC": return "Ice Crystals"
    case "PL": return "Ice Pellets"
    case "GR": return "Hail"
    case "GS": return "Small Hail"
    case "UP": return "Unknown Precipitation"
    case "BR": return "Mist"
    case "FG": return "Fog"
    case "FU": return "Smoke"
    case "VA": return "Volcanic Ash"
    case "DU": return "Widespread Dust"
    case "SA": return "Sand"
    case "HZ": return "Haze"
    case "PY": return "Spray"
    case "PO": return "Well- Developed Dust/Sand Whirls"
    case "SQ": return "Squalls"
    case "FC": return "Funnel Cloud Tornado Waterspout"
    case "SS": return "Sandstorm"
    case "RE": return "Recent"
    case "+": return "Heavy"
    case "-": return "Light"
    default: return ""
    }
}
