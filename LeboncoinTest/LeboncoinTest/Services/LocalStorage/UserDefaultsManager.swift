//
//  UserDefaultsManager.swift
//  LeboncoinTest
//
//  Created by CHEN on 12/07/2022.
//

import Foundation

/*
 UserDefaultsManager is used to store data at UserDefaults.standard
 */
class UserDefaultsManager {
    
    static var shared = UserDefaultsManager()
    var uDef = UserDefaults.standard
    
    /*
    var listOfFavoriteProducts: [Int] {
        set(newValue) {
            uDef.set(newValue, forKey: "listOfFavoriteProducts")
            uDef.synchronize()
        }
        get {
            guard uDef.object(forKey: "listOfFavoriteProducts") != nil else {
                return []
            }
            return uDef.object(forKey: "listOfFavoriteProducts") as? [Int] ?? []
        }
    }
    */
}
