//
//  MainViewController.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import UIKit
import RxSwift

class MainViewController: BaseViewController {
    
    private lazy var callListingButton: UIButton = {
        let callListingButton = UIButton()
        callListingButton.setTitle("Call List", for: .normal)
        callListingButton.setTitleColor(.black, for: .normal)
        callListingButton.backgroundColor = .lightGray
        return callListingButton
    }()
    
    private lazy var buyListingButton: UIButton = {
        let buyListingButton = UIButton()
        buyListingButton.setTitle("Buy List", for: .normal)
        buyListingButton.setTitleColor(.black, for: .normal)
        buyListingButton.backgroundColor = .lightGray
        return buyListingButton
    }()
    
    private lazy var sellListingButton: UIButton = {
        let sellListingButton = UIButton()
        sellListingButton.setTitle("Sell List", for: .normal)
        sellListingButton.setTitleColor(.black, for: .normal)
        sellListingButton.backgroundColor = .lightGray
        return sellListingButton
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: UISetupableType
extension MainViewController: UISetupableType {
    
    func setupUI() {
        view.backgroundColor = .white
        stackView.addArrangedSubview(callListingButton)
        stackView.addArrangedSubview(buyListingButton)
        stackView.addArrangedSubview(sellListingButton)
        view.addSubview(stackView)
        callListingButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        buyListingButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        sellListingButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(300)
        }
        callListingButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                /// Goto Call listing screen
                guard let self = self else { return }
                let viewModel = CallListingViewModel()
                let viewController = CallListingViewController(viewModel)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
        buyListingButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                /// Goto Buy listing screen
                guard let self = self else { return }
                let viewModel = BuyListingViewModel()
                let viewController = BuyListingViewController(viewModel)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
        sellListingButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                /// Goto Sell listing screen
                guard let self = self else { return }
                let viewModel = SellListingViewModel()
                let viewController = SellListingViewController(viewModel)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}
