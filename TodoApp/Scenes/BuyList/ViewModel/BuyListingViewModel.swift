//
//  BuyListingViewModel.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import RxSwift
import RxCocoa

final class BuyListingViewModel: UnidirectionalViewModelType {
    
    struct Input: InputType {}
    
    struct Output: OutputType {
        var buyListSubject: BehaviorSubject<[Buy]>
        var buyListError: Driver<RequestError>
        var indicatorActivity: Driver<Bool>
    }
    
    let tabBarTitle = "Buy List"
    let navigationTitle = "Buy List"
    
    private let service: BuyListService
    private let buyListSubject = BehaviorSubject<[Buy]>(value: [])
    private let buyListErrorSubject = PublishSubject<RequestError>()
    private let indicatorActivitySubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    init() {
        indicatorActivitySubject.onNext(true)
        service = BuyListService()
        fetchData()
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.buyListSubject.onNext(response)
                case .failure(let error):
                    self.buyListErrorSubject.onNext(error)
                }
                self.indicatorActivitySubject.onNext(false)
            })
            .disposed(by: disposeBag)
    }
    
    func configure(_ input: Input) -> Output {
        let buyListError = buyListErrorSubject.asDriver(onErrorJustReturn: .unknown)
        let indicatorActivity = indicatorActivitySubject.asDriver(onErrorJustReturn: false)
        return Output(buyListSubject: buyListSubject, buyListError: buyListError, indicatorActivity: indicatorActivity)
    }
    
    private func fetchData() -> Observable<Result<[Buy], RequestError>> {
        return Observable.create { observer -> Disposable in
            Task(priority: .background) {
                let result = await self.service.getBuyList()
                observer.onNext(result)
            }
            return Disposables.create()
        }
    }
    
}
