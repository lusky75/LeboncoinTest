//
//  Bundle+Extension.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

extension Bundle {
    class func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
    
    static var baseURL: String {
        guard let baseURL = infoForKey("BASE_URL"), !baseURL.isEmpty else {
            fatalError("BASE_URL not found in plist")
        }
        return baseURL
    }
}
