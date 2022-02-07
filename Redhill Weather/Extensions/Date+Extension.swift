//
//  Date+Extension.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 07/02/2022.
//

import Foundation

extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}
