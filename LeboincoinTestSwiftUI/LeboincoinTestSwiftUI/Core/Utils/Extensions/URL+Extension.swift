//
//  URL+Extension.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

extension URL {
    var removingPercentEncoding: URL {
        return URL(string: self.absoluteString.decodeUrl) ?? self
    }
}
