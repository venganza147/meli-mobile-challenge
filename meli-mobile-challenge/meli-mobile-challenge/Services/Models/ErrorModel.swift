//
//  ErrorModel.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 18/11/20.
//

import Foundation

enum ErrorApi : Error {
    case Error1(ErrorModel)
    
    func get() -> ErrorModel {
        switch self {
        case .Error1(let model):
            return model
        }
    }
}

struct ErrorModel:Codable{
    var timestamp : String?
    var statusCode : Int?
    var message : String?
    var title : String?
    
}
