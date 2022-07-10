//
//  ProductsViewModel.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation

protocol ProductsViewModelProtocol {
    
    var listOfProducts: [Product] { get set }
    
    var listOfCategories: [Category] { get set }
    
    func searchCategory(category_id: Int64) -> String
    
    func sortListOfProductsByDate()
}

class ProductsViewModel: ProductsViewModelProtocol {
    
    var listOfProducts: [Product] = []
    
    var listOfCategories: [Category] = []
    
    init() {
        
    }
    
    func searchCategory(category_id: Int64) -> String {
        if listOfCategories.isEmpty {
            return ""
        }
        for category in listOfCategories {
            if category.id == category_id {
                return category.name
            }
        }
        return ""
    }
    
    func sortListOfProductsByDate() {
        if listOfProducts.isEmpty {
            return
        }
        listOfProducts.sort(by: { $0.creation_date > $1.creation_date })
        
        /*
        for product in listOfProducts {
            print(product.creation_date)
        }
        */
    }
}
