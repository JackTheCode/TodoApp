//
//  HttpClient.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

protocol HttpClient {
    func request<T: Decodable>(_ endPoint: Endpoint, model: T.Type) async -> Result<T, RequestError>
}

extension HttpClient {
    
    func request<T: Decodable>(_ endPoint: Endpoint, model: T.Type) async -> Result<T, RequestError> {
        
        guard let url = URL(string: String(format: "%@%@", endPoint.baseUrl, endPoint.path)) else { return .failure(.invalidUrl)}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endPoint.header
        
        do {
            if let body = endPoint.body {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse) }
            switch response.statusCode {
            case 200:
                guard let decodedJson = try? JSONDecoder().decode(model, from: data) else { return .failure(.decodeError) }
                return .success(decodedJson)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
}
