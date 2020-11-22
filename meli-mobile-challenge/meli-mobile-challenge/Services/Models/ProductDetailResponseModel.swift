//
//  ProductDetailResponseModel.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 21/11/20.
//

import Foundation

struct ProductDetailResponseModel: Codable {
    
    var id: String?
    var title: String?
    var pictures: [URL]?
    var price: Double?
    
    enum RootKeys: String, CodingKey {
        case body
    }
    
    enum ItemKeys: String, CodingKey {
        case id
        case title
        case pictures
        case price
    }
    
    init() {
        id = ""
        title = ""
        pictures = []
        price = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        let rootContainer = try container.nestedContainer(keyedBy: RootKeys.self)
        let bodyContainer = try rootContainer.nestedContainer(keyedBy: ItemKeys.self, forKey: .body)
        
        id = try bodyContainer.decode(String.self, forKey: .id)
        title = try bodyContainer.decode(String.self, forKey: .title)
        
        let pics = try bodyContainer.decode([Picture].self, forKey: .pictures)
        pictures = pics.compactMap({ $0.url })
        
        price = try bodyContainer.decode(Double.self, forKey: .price)
    }
    
    private struct Description: Codable {
        var id: String?
    }
    
    private struct Picture: Codable {
        var url: URL?
    }
    
}
