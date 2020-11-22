//
//  UIButtonExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 19/11/20.
//

import Foundation
import UIKit

extension UIButton {
    func navigationSubTitleButton(){
        
        self.titleLabel?.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: 16)
        self.setTitleColor(.black, for: .normal)
        self.setImage(R.image.logoMeli(), for: .normal)
        self.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 1, left: 90, bottom: 0, right: 90)
        self.isUserInteractionEnabled = true
        
    }
    
    func navigationSubTitleWithoutButton(){
        
        self.titleLabel?.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: 16)
        self.setTitleColor(.black, for: .normal)
        self.setImage(UIImage.init(), for: .normal)
        self.isUserInteractionEnabled = false
        
    }
}
