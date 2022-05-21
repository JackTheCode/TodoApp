//
//  SellListingTableViewCell.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import UIKit

class SellListingTableViewCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    lazy var priceLabel: UILabel = {
       let priceLabel = UILabel()
        return priceLabel
    }()
    
    lazy var quantityLabel: UILabel = {
       let quantityLabel = UILabel()
        return quantityLabel
    }()
    
    var item: ItemToSell! {
        didSet {
            setItem()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SellListingTableViewCell {
    
    private func setItem() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(quantityLabel)
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(16)
            make.height.equalTo(130)
        }
        nameLabel.text = "Name: \(item.name ?? "")"
        priceLabel.text = "Price: \(item.price)"
        quantityLabel.text = "Quantity: \(item.quantity)"
    }
    
}

