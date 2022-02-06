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
