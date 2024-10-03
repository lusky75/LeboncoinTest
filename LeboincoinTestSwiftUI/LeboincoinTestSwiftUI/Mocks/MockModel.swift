//
//  MockModel.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 03/10/2024.
//

import Foundation

struct MockModel {
    
    static var getListing: [Product] {
        let listing: [Product] = load("getListing.json")
        return listing
    }
    
    /**
     Load local json and return a Codable model from the data
     */
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
