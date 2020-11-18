//
//  UIViewControllerExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 18/11/20.
//

import Foundation
import UIKit

extension UIViewController {
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        
        return topMostViewController
    }
}
