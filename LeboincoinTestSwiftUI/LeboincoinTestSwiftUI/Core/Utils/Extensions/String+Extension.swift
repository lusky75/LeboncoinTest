//
//  String+Extension.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

extension String {
    var decodeUrl: String {
        self.removingPercentEncoding ?? self
    }
}
