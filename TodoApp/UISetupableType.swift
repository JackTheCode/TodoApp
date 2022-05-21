//
//  UISetupableType.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import UIKit

protocol UISetupableType {
    func setupUI()
}

extension UISetupableType where Self: UIViewController {
    func setupUI() {}
}

extension UISetupableType where Self: UITableView {
    func setupUI() {}
}
