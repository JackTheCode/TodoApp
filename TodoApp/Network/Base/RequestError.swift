//
//  RequestError.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

enum RequestError: Error {
    case unexpectedStatusCode
    case invalidUrl
    case unknown
    case noResponse
    case decodeError
    
    var rawMessage: String {
        switch self {
        case .invalidUrl: return "Invalid URL"
        case .decodeError: return "Decode JSON error"
        default: return "Unknown error"
        }
    }
}
