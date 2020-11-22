//
//  ConnectivityExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 21/11/20.
//

import Foundation

import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
