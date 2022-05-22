//
//  CallListingViewController.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import UIKit
import SnapKit

class CallListingViewController: BaseViewController {
    
    private var viewModel: CallListingViewModel
    
    private lazy var callListTableView: UITableView = {
        let callListTableView = UITableView()
        callListTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        callListTableView.register(CallListingTableViewCell.self, forCellReuseIdentifier: String(describing: CallListingTableViewCell.self))
        return callListTableView
    }()
    
    init(_ viewModel: CallListingViewModel) {
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

// MARK: UISetupableType
extension CallListingViewController: UISetupableType {
    
    func setupUI() {
        navigationItem.title = viewModel.navigationTitle
        view.addSubview(callListTableView)
        callListTableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(0)
            make.top.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
    }
    
}

extension CallListingViewController {
    
    func bindViewModel() {
        /// Create viewModel output
        let outputs = viewModel.configure(CallListingViewModel.Input())
        /// Binding data to tableview
        outputs.callListSubject.bind(to: callListTableView.rx.items(cellIdentifier: String(describing: CallListingTableViewCell.self), cellType: CallListingTableViewCell.self)) { row, item, cell in
            cell.item = item
        }
        .disposed(by: disposeBag)
        /// Handling errors
        outputs.callListError
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.showModal("Error", message: error.rawMessage)
            })
            .disposed(by: disposeBag)
        /// Indicator activity
        outputs.indicatorActivity
            .drive(onNext: { [weak self] isShowIndicator in
                guard let self = self else { return }
                isShowIndicator ? self.showIndicator() : self.hideIndicator()
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: UITableViewDelegate
extension CallListingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    
}
