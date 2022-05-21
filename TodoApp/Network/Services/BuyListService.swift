//
//  BuyListService.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

protocol BuyistServiceInterface {
    func getBuyList() async -> Result<[Buy], RequestError>
}

struct BuyListService: HttpClient, BuyistServiceInterface {
    
    func getBuyList() async -> Result<[Buy], RequestError> {
        return await request(BuyListEndpoint.buyList, model: [Buy].self)
    }
    
}
