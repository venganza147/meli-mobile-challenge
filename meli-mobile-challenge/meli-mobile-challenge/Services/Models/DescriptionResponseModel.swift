//
//  DescriptionResponse.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 21/11/20.
//

import Foundation

struct DescriptionResponseModel: Codable {
    
    var plainText: String?
    
    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
    
}
