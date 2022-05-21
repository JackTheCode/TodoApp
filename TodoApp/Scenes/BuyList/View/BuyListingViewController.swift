//
//  BuyListingViewController.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import UIKit
import SnapKit

class BuyListingViewController: BaseViewController {
    
    private var viewModel: BuyListingViewModel
    
    private lazy var buyListTableView: UITableView = {
        let buyListTableView = UITableView()
        buyListTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        buyListTableView.register(BuyListingTableViewCell.self, forCellReuseIdentifier: String(describing: BuyListingTableViewCell.self))
        return buyListTableView
    }()
    
    init(_ viewModel: BuyListingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
}

extension BuyListingViewController: UISetupableType {
    
    func setupUI() {
        navigationItem.title = viewModel.navigationTitle
        view.addSubview(buyListTableView)
        buyListTableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(0)
            make.top.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
    }
    
}

extension BuyListingViewController {
    
    func bindViewModel() {
        let outputs = viewModel.configure(BuyListingViewModel.Input())
        outputs.buyListSubject.bind(to: buyListTableView.rx.items(cellIdentifier: String(describing: BuyListingTableViewCell.self), cellType: BuyListingTableViewCell.self)) { row, item, cell in
            cell.item = item
        }
        .disposed(by: disposeBag)
        outputs.buyListError
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.showModal("Error", message: error.rawMessage)
            })
            .disposed(by: disposeBag)
        outputs.indicatorActivity
            .drive(onNext: { [weak self] isShowIndicator in
                guard let self = self else { return }
                isShowIndicator ? self.showIndicator() : self.hideIndicator()
            })
            .disposed(by: disposeBag)
    }
    
}

extension BuyListingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    
}

