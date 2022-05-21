//
//  BuyListEndpoint.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

enum BuyListEndpoint {
    case buyList
}

extension BuyListEndpoint: Endpoint {
    
    var path: String {
        switch self { case .buyList: return "buy" }
    }
    
    var header: [String : String]? {
        switch self { case .buyList: return ["Content-Type": "application/json;charset=utf-8"] }
    }
    
    var body: [String : String]? { switch self {
        case .buyList: return nil }
    }
    
    var method: HttpMethod {
        switch self { case .buyList: return .get }
    }
    
    
}
