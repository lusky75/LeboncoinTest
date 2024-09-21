//
//  NetworkerError.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

/**
 Networker Error — enumerate list of errors from network.
 */
enum NetworkerError: Error {
    case invalidURL
    /*
    case invalidJWT
    case invalidUser
    case invalidAssetId
    case invalidExternalChannelId
    case invalidExternalVideoId
    case notConnectedUser
    case serverError(NetworkerInfo)
    case cancelled
     */
    case serverError(NetworkerInfo)
    case generic(String)
    case notFound
    case noNetwork
    /*
    case rtvError(VOFailureResponse)
    case rtvRegisterTerminalError(VOFailureResponse) // Error created to manage error screens
    case compassUpdateError // Error created to manage error screens
    case compassError(VOFailureResponse)
    case invalidRegisterTerminal
    case genericError(NetworkerGenericError)
    case sessionLimitReached
    case geoblocked // Error created to manage error screens
    case invalidTerminal(VOFailureResponse)
     */
}

struct NetworkerInfo {
    let url: String
    let statusCode: Int
}

struct NetworkerGenericError {
    let title: String
    let message: String
}

extension Error {
    var message: String {
        if let error = self as? NetworkerError {
            switch error {
            case .generic(let message):
                return message
            default:
                return error.localizedDescription
            }
        }
        return self.localizedDescription
    }
}
