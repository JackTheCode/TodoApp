//
//  CallListService.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

protocol CallListServiceInterface {
    func getCallList() async -> Result<[Call], RequestError>
}

struct CallListService: HttpClient, CallListServiceInterface {
    
    func getCallList() async -> Result<[Call], RequestError> {
        return await request(CallListEndpoint.callList, model: [Call].self)
    }
    
}
