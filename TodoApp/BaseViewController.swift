//
//  BaseViewController.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import UIKit
import RxSwift
import MBProgressHUD

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    func showModal(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func showIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            MBProgressHUD.showAdded(to: self.navigationController!.view, animated: true)
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            MBProgressHUD.hide(for: self.navigationController!.view, animated: true)
        }
    }
    
}
