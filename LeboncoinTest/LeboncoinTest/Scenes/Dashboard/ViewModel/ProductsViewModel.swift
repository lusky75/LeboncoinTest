//
//  ProductsViewModel.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation

protocol ProductsViewModelProtocol {
    
    var listOfProducts: [Product] { get set }
    
    var isFiltered: Bool { get set }
    
    var listOfFilteredProducts: [Product] { get set }
    
    var listOfCategories: [CategoryModel] { get set }
    
    var listOfSelectedCategories: [Bool] { get set }
    
    func searchCategory(category_id: Int64) -> String
    
    func sortListOfProductsByDate(completion: (() -> ()))
    
    func filterListOfProductsBySelectedCategories(completion: (() -> ()))
}

class ProductsViewModel: ProductsViewModelProtocol {
    
    var listOfProducts: [Product] = []
    
    var isFiltered: Bool = false
    
    var listOfFilteredProducts: [Product] = []
    
    var listOfCategories: [CategoryModel] = []
    
    var listOfSelectedCategories: [Bool] = []
    
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
    
    func sortListOfProductsByDate(completion: (() -> ())) {
        if listOfProducts.isEmpty {
            return
        }
        
        var productDatetime: TimeInterval = 0
        for index in listOfProducts.indices {
            productDatetime = Date().convertStringToDate(fromDate: listOfProducts[index].creation_date).timeIntervalSince1970
            listOfProducts[index].creation_datetime = productDatetime
        }
        
        listOfProducts.sort(by: {
            $0.creation_datetime ?? 0 > $1.creation_datetime ?? 0
        })
        
        listOfProducts.sort(by: {
            $0.is_urgent && !$1.is_urgent
        })
        completion()
    }
    
    func filterListOfProductsBySelectedCategories(completion: (() -> ())) {
        listOfFilteredProducts.removeAll()
        if listOfSelectedCategories.isEmpty {
            return
        }
        var filteredListOfProducts: [Product] = []
        var productIsInCategory: Bool = false
    
        for product in listOfProducts {
            productIsInCategory = false
            for index in listOfCategories.indices {
                if product.category_id == listOfCategories[index].id && listOfSelectedCategories[index] == true {
                    productIsInCategory = true
                }
            }
            if productIsInCategory == true {
                filteredListOfProducts.append(product)
            }
        }

        listOfFilteredProducts = filteredListOfProducts
        completion()
    }
}
