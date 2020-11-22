//
//  DoubleExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 19/11/20.
//

import Foundation

extension Double {
    
    func toPriceString() -> String {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .decimal
        priceFormatter.maximumFractionDigits = 0
        priceFormatter.groupingSeparator = "."
        if let priceString = priceFormatter.string(from: self as NSNumber)?.replacingOccurrences(of: " ", with: "") {
            return "$" + priceString
        }
        return ""
    }
    
}
