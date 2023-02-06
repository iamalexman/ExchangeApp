//
//  APIService.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 18.08.2022.
//

import Foundation

protocol APIService {
    func load<T: Codable>(url: URLBuilder,
                                 responseModel: T.Type) async -> Result<T, APIError>
}

// MARK: - Extension for Network layer service works on generic types and async/await

extension APIService {
    
    func load<T: Codable>(url: URLBuilder,
                                 responseModel: T.Type) async -> Result<T, APIError> {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = url.scheme
        urlComponents.host = url.host
        urlComponents.path = url.path
        urlComponents.queryItems = url.query
        
        guard let urlWithComponents = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: urlWithComponents)
        
        request.httpMethod = url.method.rawValue
        request.allHTTPHeaderFields = url.header
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodeResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                print(decodeResponse)
                return .success(decodeResponse)
            case 401:
                return .failure(.unauhorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknownError)
        }
    }
}
