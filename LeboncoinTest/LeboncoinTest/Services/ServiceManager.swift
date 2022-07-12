//
//  ServiceManager.swift
//  LeboncoinTest
//
//  Created by CHEN on 09/07/2022.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badUrl(String)
    case badResponse(Int, String)
    case invalidData(String, String)
    case invalidDecode(String, String)
    
    var localizedDescription: String {
        switch self {
        case .badUrl(let url):
            return "Invalid URL - url:\(url)"
        case .badResponse(let statusCode, let requestName):
            return "Error Response for request: \(requestName) - Status Code:\(statusCode)"
        case .invalidData(let error, let requestName):
            return "Error Data for request: \(requestName) - error:\(error)"
        case .invalidDecode(let error, let requestName):
            return "JSON decode failed for request \(requestName) - error:\(error)"
        }
    }
}


struct ServicesAPI {
    
    static let host: String = "https://raw.githubusercontent.com"
    
    static let basePath: String = "/leboncoin/paperclip/master"
    
    static var listingProducts: String = "/listing.json"
    
    static var productCategories: String = "/categories.json"
    
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
    
    var endpoint: String {
        switch self {
        case .listingProducts:
            return ServicesAPI.listingProducts
        case .productCategories:
            return ServicesAPI.productCategories
        }
    }
}

class ServicesAPIManager: NSObject, URLSessionDelegate {
    
    static let shared = ServicesAPIManager()
    
    func fetchProductsList(url: Endpoint, completionHandler: @escaping ([Product]?, NetworkError?) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        guard let endpoint = URL(string: url.source) else {
            completionHandler(nil, .badUrl(url.source))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        

        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completionHandler(nil,
                    .badResponse(
                        (response as? HTTPURLResponse)?.statusCode ?? 0, url.endpoint
                    )
                )
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(nil,
                                  .invalidData(error.debugDescription, url.endpoint)
                                  )
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseJSON = try decoder.decode([Product].self, from: data)
                completionHandler(responseJSON, nil)
            } catch {
                completionHandler(nil,
                    .invalidDecode(error.localizedDescription, url.endpoint)
                )
            }
        }
        task.resume()
    }
    
    func fetchProductCategories(url: Endpoint, completionHandler: @escaping ([CategoryModel]?, NetworkError?) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        guard let endpoint = URL(string: url.source) else {
            completionHandler(nil, .badUrl(url.source))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        

        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completionHandler(nil,
                    .badResponse(
                        (response as? HTTPURLResponse)?.statusCode ?? 0, url.endpoint
                    )
                )
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(nil,
                    .invalidData(error.debugDescription, url.endpoint)
                )
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseJSON = try decoder.decode([CategoryModel].self, from: data)
                completionHandler(responseJSON, nil)
            } catch {
                completionHandler(nil,
                    .invalidDecode(error.localizedDescription, url.endpoint)
                )
            }
        }
        task.resume()
    }
    
}
