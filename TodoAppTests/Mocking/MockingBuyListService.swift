//
//  MockingBuyListService.swift
//  TodoAppTests
//
//  Created by phat nguyen on 5/22/22.
//

import XCTest
import RxSwift
@testable import TodoApp

final class MockingBuyListService: ServiceMock, BuyListServiceInterface {
    
    func getBuyList() async -> Result<[Buy], RequestError> {
        return .success(loadJson("buy_list", type: [Buy].self))
    }
    
}
