//
//  NetworkStatus.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation

// swiftlint:disable identifier_name
enum NetworkerStatus: Int {
    case OK = 200
    case CREATED = 201
    case INTERNAL_SERVER_ERROR = 500
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case CONFLICT = 409
    case SERVICE_UNAVAILABLE = 503
    case NOT_FOUND = 404
    case TIMEOUT = -1001
    case NETWORK_KO = -1009
}
// swiftlint:enable identifier_name
