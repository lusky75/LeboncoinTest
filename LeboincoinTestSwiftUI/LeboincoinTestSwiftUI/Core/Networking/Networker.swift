//
//  Networker.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation
import Combine

/**
 Network Controller is responsible for working directly with URLSessionTasks and decoding a Codable model from the data.
 Combine — Customize handling of asynchronous events by combining event-processing operators.
 */

typealias Headers = [String: Any]
typealias Params = [String: Any]

protocol NetworkerProtocol: AnyObject {
    func get<T>(url: URL,
                headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    
    func getWithoutEncoding<T>(url: URL,
                               headers: Headers) -> AnyPublisher<T, Error> where T : Decodable
    
    func getData(url: URL,
                 headers: Headers) -> AnyPublisher<Data, Error>
    func post<T>(url: URL,
                 parameters: Params,
                 headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    func post<T>(url: URL,
                 body: String,
                 headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    func put(url: URL, headers: Headers) -> AnyPublisher<Bool, Error>
    func delete(url: URL,
                headers: Headers) -> AnyPublisher<Bool, Error>
    func delete(url: URL,
                bodyJson: String?,
                headers: Headers) -> AnyPublisher<Bool, Error>
    func patch<T>(url: URL,
                  parameters: Params,
                  headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    func patch<T>(url: URL,
                  body: String,
                  headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    func hit(urlString: String) -> AnyPublisher<Bool, Error>
}

final class Networker: NetworkerProtocol {
    
    private func debugData(data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            Log.pretty(json)
        } catch {
            Log.error("debugData error: \(error)")
        }
    }
    
    private func getResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode else {
            throw NetworkerError.serverError(NetworkerInfo(url: (response as? HTTPURLResponse)?.url?.absoluteString ?? "",
                                                           statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
        }
        
        return data
    }
    /**
     returns a publisher containing a model
     */
    func get<T>(url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        Log.pretty(urlRequest)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                self.debugData(data: data)
                return try self.getResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getWithoutEncoding<T>(url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url.removingPercentEncoding)
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        Log.pretty(urlRequest)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
//                self.debugData(data: data)
                return try self.getResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getData(url: URL, headers: Headers) -> AnyPublisher<Data, Error> {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                return try self.getResponse(data: data, response: response)
            }
            .eraseToAnyPublisher()
    }
    
    func post<T>(url: URL, parameters: Params, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            Log.error(error.localizedDescription)
        }
        
        Log.pretty(urlRequest)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                return try self.getResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func post<T>(url: URL, body: String, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        Log.pretty(urlRequest)
        
        let data = body.data(using: .utf8)
        urlRequest.httpBody = data
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { data, response in
                    return try self.getResponse(data: data, response: response)
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
    }
    
    func put(url: URL, headers: Headers) -> AnyPublisher<Bool, Error> {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        Log.pretty(urlRequest)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { _, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                          throw NetworkerError.serverError(NetworkerInfo(url: url.absoluteString, statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
                      }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    func delete(url: URL, headers: Headers) -> AnyPublisher<Bool, Error> {
        delete(url: url, bodyJson: nil, headers: headers)
    }
    
    func delete(url: URL, bodyJson: String?, headers: Headers) -> AnyPublisher<Bool, Error> {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"

        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let body = bodyJson, !body.isEmpty, let data = body.data(using: .utf8) {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { _, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                          throw NetworkerError.serverError(NetworkerInfo(url: url.absoluteString, statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
                      }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    func patch<T>(url: URL, parameters: Params, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "PATCH"

        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body

        } catch let error {
            Log.error(error.localizedDescription)
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                return try self.getResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func patch<T>(url: URL, body: String, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "PATCH"

        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        let data = body.data(using: .utf8)
        urlRequest.httpBody = data

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                return try self.getResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func hit(urlString: String) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkerError.invalidURL)
                .eraseToAnyPublisher()
        }
       
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return true
            }
            .eraseToAnyPublisher()
    }
}
