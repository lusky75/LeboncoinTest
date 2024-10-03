//
//  URL+Extension.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

extension URL {
    func addQueryParams(queryItems: [URLQueryItem]) -> URL {
        // Resizer image for Orange repository image
        var urlComps = URLComponents(url: self, resolvingAgainstBaseURL: false)
        urlComps?.queryItems = queryItems
        return urlComps?.url ?? self
    }
    
    var removingPercentEncoding: URL {
        return URL(string: self.absoluteString.decodeUrl) ?? self
    }
    
    var addingPercentEncoding: URL {
        // dont encode if already encoded
        guard !isAlreadyEncoded else { return self }
        return URL(string: self.absoluteString.encodeUrl) ?? self
    }

    /// Decode, compare to original. If it does differ, original is encoded
    /// https://stackoverflow.com/a/56929254
    private var isAlreadyEncoded: Bool {
        self.absoluteString.decodeUrl != self.absoluteString
    }
}
