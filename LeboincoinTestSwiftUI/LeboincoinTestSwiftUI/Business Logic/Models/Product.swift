//
//  Product.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

struct Product: Codable, Hashable {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Float
    let imagesUrl: ImageUrl?
    let creationDate: String
    let isUrgent: Bool
    
    var category: String?
    
    struct ImageUrl: Codable {
        let small: String?
        let thumb: String?
    }
    
    enum CodingKeys: String, CodingKey, Codable {
        case id
        case categoryId = "category_id"
        case title, description, price
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}

// MARK: Methods
extension Product {
    static func fake() -> Self {
        return MockModel.getListing[0]
    }
    
    mutating func updateCategory(category: String) {
        self.category = category
    }
}

// MARK: Hashable
extension Product {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
