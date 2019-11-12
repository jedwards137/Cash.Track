//
//  TransactionCell.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

public class TransactionCell : UICollectionViewCell {
    private let NameLabel : UILabel = {
        let label = UILabel()
        label.text = "transaction"
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let AmountLabel : UILabel = {
        let label = UILabel()
        label.text = "+-0.00"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        addSubviews()
        anchorSubviews()
    }
    
    public func setTransactionInfo(transaction: Transaction) {
        NameLabel.text = transaction.Name
        let amount = transaction.getAdjustedAmount()
        AmountLabel.text = amount.round()
        
        let amountIsPositive = amount > 0
        self.backgroundColor = amountIsPositive ? GlobalValues.customGreen : GlobalValues.customRed
    }
    
    private func addSubviews() {
        let subviews = [NameLabel, AmountLabel]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    private func anchorSubviews() {
        let edgePadding : CGFloat = 10
        NameLabel.setCenterYAnchor(to: self.centerYAnchor)
        NameLabel.setLeadingAnchor(to: self.leadingAnchor, withPadding: edgePadding)
        
        AmountLabel.setCenterYAnchor(to: self.centerYAnchor)
        AmountLabel.setTrailingAnchor(to: self.trailingAnchor, withPadding: -edgePadding)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
