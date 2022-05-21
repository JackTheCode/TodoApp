//
//  CallListingViewModel.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import RxSwift
import RxCocoa

final class CallListingViewModel: UnidirectionalViewModelType {
    
    struct Input: InputType {}
    
    struct Output: OutputType {
        var callListSubject: BehaviorSubject<[Call]>
        var callListError: Driver<RequestError>
        var indicatorActivity: Driver<Bool>
    }
    
    let tabBarTitle = "Call List"
    let navigationTitle = "Call List"
    
    private let service: CallListService
    private let callListSubject = BehaviorSubject<[Call]>(value: [])
    private let callListErrorSubject = PublishSubject<RequestError>()
    private let indicatorActivitySubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    init() {
        indicatorActivitySubject.onNext(true)
        service = CallListService()
        fetchData()
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.callListSubject.onNext(response)
                case .failure(let error):
                    self.callListErrorSubject.onNext(error)
                }
                self.indicatorActivitySubject.onNext(false)
            })
            .disposed(by: disposeBag)
    }
    
    func configure(_ input: Input) -> Output {
        let callListError = callListErrorSubject.asDriver(onErrorJustReturn: .unknown)
        let indicatorActivity = indicatorActivitySubject.asDriver(onErrorJustReturn: false)
        return Output(callListSubject: callListSubject, callListError: callListError, indicatorActivity: indicatorActivity)
    }
    
    private func fetchData() -> Observable<Result<[Call], RequestError>> {
        return Observable.create { observer -> Disposable in
            Task(priority: .background) {
                let result = await self.service.getCallList()
                observer.onNext(result)
            }
            return Disposables.create()
        }
    }
    
}
