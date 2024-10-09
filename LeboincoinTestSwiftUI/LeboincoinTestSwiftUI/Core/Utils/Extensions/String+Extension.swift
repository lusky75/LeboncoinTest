//
//  String+Extension.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

// MARK: Fonts
extension String {
    /// Font names
    static let helveticaNeue35: Self = "HelveticaNeue-Thin"
    static let helveticaNeue45: Self = "HelveticaNeue-Light"
    static let helveticaNeue55: Self = "HelveticaNeue-Roman"
    static let helveticaNeue65: Self = "HelveticaNeue-Medium"
    static let helveticaNeue75: Self = "HelveticaNeue-Bold"
}

extension String {
    var decodeUrl: String {
        self.removingPercentEncoding ?? self
    }
    
    var encodeUrl: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? self
    }
    
    func path(at position: Int, separatedBy: String = "/") -> String? {
        let splitArray = String(self.dropFirst()).components(separatedBy: separatedBy)
        
        guard splitArray.indices.contains(position) else { return nil }
        return splitArray[position]
    }
}
