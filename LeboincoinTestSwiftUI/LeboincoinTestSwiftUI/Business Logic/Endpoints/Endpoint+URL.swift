//
//  Endpoint+URL.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

/**
 Extension in which we construct the URL for API
 */

extension Endpoint {
    var baseUrl: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.baseURL
        components.path = (version ?? "") + (path ?? "")
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    var customUrl: URL {
        guard var components = URLComponents(string: path ?? "") else {
            preconditionFailure("Invalid URL components for path: \(path ?? "")")
        }
        if components.queryItems == nil {
            components.queryItems = []
        }
        components.queryItems?.append(contentsOf: queryItems ?? [])
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}
