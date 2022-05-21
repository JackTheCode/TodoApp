//
//  SellListingViewController.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import Foundation
import UIKit
import SnapKit

class SellListingViewController: BaseViewController {
    
    private var viewModel: SellListingViewModel
    
    private lazy var sellListTableView: UITableView = {
        let sellListTableView = UITableView()
        sellListTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        sellListTableView.register(SellListingTableViewCell.self, forCellReuseIdentifier: String(describing: SellListingTableViewCell.self))
        return sellListTableView
    }()
    
    init(_ viewModel: SellListingViewModel) {
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

extension SellListingViewController: UISetupableType {
    
    func setupUI() {
        navigationItem.title = viewModel.navigationTitle
        view.addSubview(sellListTableView)
        sellListTableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(0)
            make.top.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
    }
    
}

extension SellListingViewController {
    
    func bindViewModel() {
        let outputs = viewModel.configure(SellListingViewModel.Input())
        outputs.sellListSubject.bind(to: sellListTableView.rx.items(cellIdentifier: String(describing: SellListingTableViewCell.self), cellType: SellListingTableViewCell.self)) { row, item, cell in
            cell.item = item
        }
        .disposed(by: disposeBag)
    }
    
}

extension SellListingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    
}


