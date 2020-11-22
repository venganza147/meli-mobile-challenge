//
//  ErrorExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 20/11/20.
//

import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
