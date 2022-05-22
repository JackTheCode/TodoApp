//
//  TodoAppTests.swift
//  TodoAppTests
//
//  Created by phat nguyen on 5/21/22.
//

import XCTest
import RxSwift
@testable import TodoApp

class TodoAppTests: XCTestCase {
    
    private let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCallListServiceMock() async {
        let mockingCallListService = MockingCallListService()
        let result = await mockingCallListService.getCallList()
        switch result {
        case .success(let callList):
            XCTAssertEqual(callList.count, 3)
            XCTAssertEqual(callList.first?.name, "Jason White")
        case .failure(let error):
            XCTFail(error.rawMessage)
        }
    }
    
    func testBuyListServiceMock() async {
        let mockingBuyListService = MockingBuyListService()
        let result = await mockingBuyListService.getBuyList()
        switch result {
        case .success(let buyList):
            XCTAssertEqual(buyList.count, 3)
            XCTAssertEqual(buyList.first?.name, "MacBook Pro")
        case .failure(let error):
            XCTFail(error.rawMessage)
        }
    }

    func testCallListFetchData() {
        var data: [Call] = [Call]()
        var count = 0
        let viewModel = CallListingViewModel()
        let outputs = viewModel.configure(CallListingViewModel.Input())
        let exp = expectation(description: "Fetch data from calling service")
        outputs.callListSubject.asDriver(onErrorJustReturn: [])
            .drive(onNext: { callList in
                count += 1
                data = callList
                if count > 1 {
                    if callList.isEmpty {
                        XCTFail("Call list data is empty")
                    }
                    exp.fulfill()
                }
            })
            .disposed(by: disposeBag)
        outputs.callListError
            .drive(onNext: { error in
                XCTFail(error.rawMessage)
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertEqual(data.count, 3)
        XCTAssertEqual(data.first?.name, "Jason White")
    }
    
    func testBuyListFetchData() {
        var data: [Buy] = [Buy]()
        var count = 0
        let viewModel = BuyListingViewModel()
        let outputs = viewModel.configure(BuyListingViewModel.Input())
        let exp = expectation(description: "Fetch data from buying service")
        outputs.buyListSubject.asDriver(onErrorJustReturn: [])
            .drive(onNext: { buyList in
                count += 1
                data = buyList
                if count > 1 {
                    if buyList.isEmpty {
                        XCTFail("Buy list data is empty")
                    }
                    exp.fulfill()
                }
            })
            .disposed(by: disposeBag)
        outputs.buyListError
            .drive(onNext: { error in
                XCTFail(error.rawMessage)
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertEqual(data.count, 3)
        XCTAssertEqual(data.first?.name, "MacBook Pro")
    }
    
    func testSellListFetchData() {
        var data: [ItemToSell] = [ItemToSell]()
        let viewModel = SellListingViewModel()
        let outputs = viewModel.configure(SellListingViewModel.Input())
        let exp = expectation(description: "Fetch data from core data")
        outputs.sellListSubject.asDriver(onErrorJustReturn: [])
            .drive(onNext: { sellList in
                data = sellList
                if sellList.isEmpty {
                    XCTFail("Sell list data is empty")
                }
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertEqual(data.count, 3)
        XCTAssertEqual(data.first?.name, "iPhone X")
    }
    
}
