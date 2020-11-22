//
//  UILabelExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 19/11/20.
//

import Foundation
import UIKit

extension UILabel {
    
    func navigationTitleLabel(){
        
        let attributedString = NSMutableAttributedString(string: self.text ?? "Mercado Libre")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(2.0), range: NSRange(location: 0, length: attributedString.length))
        self.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: Helper.size(size: 12))
        self.textColor = UIColor.lightGray
        self.textAlignment = .center
        self.sizeToFit()
        
        self.attributedText = attributedString
        
    }
}
