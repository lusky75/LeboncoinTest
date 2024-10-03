//
//  Category.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

struct Category: Codable, Equatable {
    let id: Int
    let name: String
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name
    }
}
