//
//  ApiManager.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 17/11/20.
//

import Foundation
import Moya

enum Api {
    case searchItems(parameters:[String:String])
    case fetchItem(parameters:[String:String])
    case fetchDescription(productId: String)
}

extension Api: TargetType {
    
    public var baseURL: URL { return URL(string: Helper.config(attr: .url))! }
    
    var path: String {
        switch self {

        case .searchItems:
            return "/sites/MLC/search"
        case .fetchItem:
            return "/items"
        case .fetchDescription(let productId):
            return "/items/\(productId)/description"
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
    public var method: Moya.Method {
        switch self {
        case .searchItems, .fetchItem, .fetchDescription:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchItems(parameters: let parameters), .fetchItem(parameters: let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .fetchDescription:
            let parameters = [
                "lang": "es",
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
