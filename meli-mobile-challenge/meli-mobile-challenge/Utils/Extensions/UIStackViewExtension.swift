//
//  UIStackViewExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 21/11/20.
//

import Foundation
import UIKit

extension UIStackView {
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
