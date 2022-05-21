//
//  SellListingViewModel.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import RxSwift
import RxCocoa

final class SellListingViewModel: UnidirectionalViewModelType {
    
    struct Input: InputType {}
    
    struct Output: OutputType {
        var sellListSubject: BehaviorSubject<[ItemToSell]>
    }
    
    let tabBarTitle = "Sell List"
    let navigationTitle = "Sell List"
    private let sellListSubject = BehaviorSubject<[ItemToSell]>(value: [])
    
    init() {
        fetchData()
    }
    
    func configure(_ input: Input) -> Output {
        return Output(sellListSubject: sellListSubject)
    }
    
    private func fetchData() {
        CoreDataStack.sharedInstance.fetch()
        if CoreDataStack.sharedInstance.sellList.isEmpty {
            let now = Date()
            CoreDataStack.sharedInstance.store(1, name: "iPhone X", price: 150000, quantity: 1, type: 2, createOn: now)
            CoreDataStack.sharedInstance.store(2, name: "TV", price: 38000, quantity: 2, type: 2, createOn: now)
            CoreDataStack.sharedInstance.store(3, name: "Table", price: 12000, quantity: 1, type: 2, createOn: now)
        }
        sellListSubject.onNext(CoreDataStack.sharedInstance.sellList)
    }
    
}
