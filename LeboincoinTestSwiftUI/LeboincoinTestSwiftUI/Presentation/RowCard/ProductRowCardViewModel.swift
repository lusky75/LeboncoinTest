//
//  ProductRowCardViewModel.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 03/10/2024.
//

import Foundation

final class ProductRowCardViewModel: ObservableObject {
    private let model: Product
    
    lazy var imageUrl: URL? = {
        guard let image = model.imagesUrl?.small,
              let url = URL(string: image) else {
            return nil
        }
        return url
    }()
    
    init(model: Product) {
        self.model = model
    }
    
    var title: String? {
        model.title
    }
    
    var price: String? {
        String(model.price) + " €"
    }
    
    var category: String? {
        model.category
    }
    
    var urgentTitle: String {
        "Vente urgente"
    }
    
    var isUrgent: Bool {
        model.isUrgent
    }
}
