//
//  ColorExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 19/11/20.
//

import Foundation
import SwiftUI
import UIKit

extension UIColor {
    
    func toColor() -> Color {
        let rgbColours = self.cgColor.components
        return Color(
            red: Double(rgbColours![0]),
            green: Double(rgbColours![1]),
            blue: Double(rgbColours![2])
        )
    }
}

