//
//  FavoriteModel.swift
//  LeboncoinTest
//
//  Created by CHEN on 12/07/2022.
//

import Foundation

class Favorites: ObservableObject {
    
    @Published var products: Set<Product> = []
    //@Published var favorites: Set<Int64> = []
    let defaults = UserDefaults.standard

    var initialItems: [Product] = []

    init() {
        let decoder = PropertyListDecoder()
        
        if let data = defaults.data(forKey: "listOfFavoriteProducts") {
            products = (try? decoder.decode(Set<Product>.self, from: data)) ?? Set(initialItems)
        } else {
            products = Set(initialItems)
        }
    }

    /*
    func getTaskIds() -> Set<Int64> {
        return self.favorites
    }
    */

    func contains(_ product: Product) -> Bool {
        if products.contains(product) {
            return true
        }
        return false
    }

    func add(_ product: Product) {
        //favorites.insert(product.id)
        products.insert(product)
        save()
    }

    func remove(_ product: Product) {
        //favorites.remove(product.id)
        products.remove(product)
        save()
    }

    func save() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(self.products) {
            self.defaults.set(encoded, forKey: "listOfFavoriteProducts")
        }
        defaults.synchronize()
    }
    
    deinit {
        
    }
}
