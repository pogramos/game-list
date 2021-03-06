//
//  ClientError.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

enum ErrorStrings: String {
    case unauthorized
    case error
    case encode_failure
    case decode_failure
    case not_found
    case wrong_path
    case unavailable_connection

    var localized: String {
        return self.rawValue.localized()
    }
}

enum ClientError: Error {
    case unauthorized(Error?)
    case error(Error?)
    case apiError(IGDBError?)
    case encodeFailure(Error?)
    case decodeFailure(Error?)
    case networkFailure(Error?)
    case noResultsFound(Error?)
    case unavailableConnection(Error?)

    var localizedDescription: String {
        switch self {
        case .unauthorized(let error): return "\(ErrorStrings.unauthorized.localized) \(String(describing: error?.localizedDescription))"
        case .encodeFailure(let error): return "\(ErrorStrings.encode_failure.localized) \(String(describing: error?.localizedDescription))"
        case .decodeFailure(let error): return "\(ErrorStrings.decode_failure.localized) \(String(describing: error?.localizedDescription))"
        case .noResultsFound(let error): return "\(ErrorStrings.not_found.localized) \(String(describing: error?.localizedDescription))"
        case .unavailableConnection(let error): return "\(ErrorStrings.unavailable_connection.localized) \(String(describing: error?.localizedDescription))"
        case .error(let error),
             .networkFailure(let error): return "\(ErrorStrings.error.localized) \(String(describing: error?.localizedDescription))"
        case .apiError(let error):
            if let message = error?.err?.message {
                return "IGDB Warning: \(message)"
            } else {
                return ErrorStrings.not_found.localized
            }
        }
    }
}
