//
//  CallListEndpoint.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

enum CallListEndpoint {
    case callList
}

extension CallListEndpoint: Endpoint {
    
    var path: String {
        switch self { case .callList: return "call" }
    }
    
    var header: [String : String]? {
        switch self { case .callList: return ["Content-Type": "application/json;charset=utf-8"] }
    }
    
    var body: [String : String]? { switch self {
        case .callList: return nil }
    }
    
    var method: HttpMethod {
        switch self { case .callList: return .get }
    }
    
    
}
