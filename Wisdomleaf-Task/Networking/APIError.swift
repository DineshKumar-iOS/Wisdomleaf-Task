//
//  APIError.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

/// This is an enumeration that defines a set of errors that can occur while making network requests.
enum ApiError: Error {
    case requestFailed(description: String)
    case invalidData
    case invalidURL
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet
    case noResponse
    case unexpectedStatusCode
    case unknown

    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data)"
        case .invalidURL: return "Invalid Url"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        default: return "Unknown error"
        }
    }
}
