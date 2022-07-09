//
//  ProductsViewModel.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation

protocol ProductsViewModelProtocol {
    
    var listOfProducts: [Product] { get set }
    
}

class ProductsViewModel: ProductsViewModelProtocol {
    
    var listOfProducts: [Product] = []
    
    init() {
        
    }
}
