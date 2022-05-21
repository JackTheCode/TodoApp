//
//  CallListingTableViewCell.swift
//  TodoApp
//
//  Created by phat nguyen on 5/21/22.
//

import UIKit

class CallListingTableViewCell: UITableViewCell {
    
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
    
    lazy var numberLabel: UILabel = {
       let numberLabel = UILabel()
        return numberLabel
    }()
    
    var item: Call! {
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

extension CallListingTableViewCell {
    
    private func setItem() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(numberLabel)
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(16)
            make.height.equalTo(100)
        }
        nameLabel.text = "Name: \(item.name)"
        numberLabel.text = "Number: \(item.number)"
    }
    
}
