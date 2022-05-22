//
//  MockingCallListService.swift
//  TodoAppTests
//
//  Created by phat nguyen on 5/22/22.
//

import XCTest
import RxSwift
@testable import TodoApp

final class MockingCallListService: ServiceMock, CallListServiceInterface {
    
    func getCallList() async -> Result<[Call], RequestError> {
        return .success(loadJson("call_list", type: [Call].self))
    }
    
}
