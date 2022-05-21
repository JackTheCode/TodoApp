//
//  Endpoint.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var method: HttpMethod { get }
}

extension Endpoint {
    
    var baseUrl: String {
        return "https://my-json-server.typicode.com/imkhan334/demo-1/"
    }
    
}
