//
//  UnidirectionalViewModelType.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation

protocol InputType {}

protocol OutputType {}

protocol UnidirectionalViewModelType: ViewModelType {
    associatedtype Input: InputType
    associatedtype Output: OutputType
    func configure(_ input: Input) -> Output
}
