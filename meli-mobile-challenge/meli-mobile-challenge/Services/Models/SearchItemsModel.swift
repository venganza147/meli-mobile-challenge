//
//  SearchItemsModel.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 21/11/20.
//

import Foundation

struct SearchItemsModel: Codable {
    
    var query: String?
    var results: [SearchItemModel]?
    
}
