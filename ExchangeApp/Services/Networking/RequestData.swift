//
//  Enums.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 18.08.2022.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauhorized
    case unexpectedStatusCode
    case unknownError
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauhorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
