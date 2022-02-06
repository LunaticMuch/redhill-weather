//
//  Collection+Extension.swift
//  Redhill Weather
//
//  Created by Stefano Cislaghi on 06/02/2022.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
