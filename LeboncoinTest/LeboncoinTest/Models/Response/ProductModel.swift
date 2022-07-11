//
//  ProductModel.swift
//  LeboncoinTest
//
//  Created by CHEN on 09/07/2022.
//

import Foundation

struct ImageURL: Codable {
    var small: String?
    var thumb: String?
}

struct Product: Codable {
    var id: Int64
    var category_id: Int64
    var title: String
    var description: String
    var price: Float
    var images_url: ImageURL?
    var creation_date: String
    var is_urgent: Bool
    var siret: String?
    
    var creation_datetime: TimeInterval?
    
    mutating func updateCreationDatetime(datetime: TimeInterval) {
        creation_datetime = datetime
    }
}
