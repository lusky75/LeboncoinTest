//
//  Product.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

struct Product: Codable {
    let id: Int
    let categoryId: Int
    let description: String
    let price: Float
    let imagesUrl: ImageUrl?
    let creationDate: String
    let isUrgent: Bool
    
    struct ImageUrl: Codable {
        let small: String?
        let thumb: String?
    }
    
    enum CodingKeys: String, CodingKey, Codable {
        case id
        case categoryId = "category_id"
        case description, price
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}
