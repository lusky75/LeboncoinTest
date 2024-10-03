//
//  HomeService.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation
import Combine

protocol HomeServiceProtocol: AnyObject {
    func getCategories() -> AnyPublisher<[Category], Error>
    func getListing() -> AnyPublisher<[Product], Error>
}

final class HomeService: HomeServiceProtocol {
    private let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getCategories() -> AnyPublisher<[Category], Error> {
        let baseUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
        let endpoint = Endpoint.getCategories(path: baseUrl)
        
        return networker.get(url: endpoint.customUrl, headers: endpoint.headers)
    }
    
    func getListing() -> AnyPublisher<[Product], Error> {
        let baseUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
        let endpoint = Endpoint.getListing(path: baseUrl)
        
        return networker.get(url: endpoint.customUrl, headers: endpoint.headers)
    }
}
