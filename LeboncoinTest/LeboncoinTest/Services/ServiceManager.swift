//
//  ServiceManager.swift
//  LeboncoinTest
//
//  Created by CHEN on 09/07/2022.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badUrl
    case badResponse
    case invalidDecode
    
    var localizedDescription: String {
        switch self {
        case .badUrl:
            return "Invalid URL"
        case .badResponse:
            return "Error Response"
        case .invalidDecode:
            return "JSON decode failed"
        }
    }
}


struct ServicesAPI {
    static var listingProducts: String = "/listing.json"
    
    static var productCategories: String = "/categories.json"
    
    static let host: String = "https://raw.githubusercontent.com"
    
    static let basePath: String = "/leboncoin/paperclip/master"
    
}


enum Endpoint {
    case listingProducts
    case productCategories
    
    var source: String {
        switch self {
        case .listingProducts:
            return ServicesAPI.host + ServicesAPI.basePath + ServicesAPI.listingProducts
        case .productCategories:
            return ServicesAPI.host + ServicesAPI.basePath + ServicesAPI.productCategories
        }
    }
}

class ServicesAPIManager: NSObject, URLSessionDelegate {
    
    static let shared = ServicesAPIManager()
    
    func fetchProductsList(url: Endpoint, completionHandler: @escaping ([Product]?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        guard let endpoint = URL(string: url.source) else {
            print("error endpoint")
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        

        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard let data = data, error == nil else {
                print("error data", error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseJSON = try decoder.decode([Product].self, from: data)
                print(responseJSON)
                completionHandler(responseJSON, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
}
