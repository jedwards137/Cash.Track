//
//  TransactionCell.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/7/19.
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
    private let DateLabel : UILabel = {
        let label = UILabel()
        label.text = "00/00/0000 @ 00:00"
        label.textColor = .gray
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 10)
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
        
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        addSubviews()
        anchorSubviews()
    }
    
    public func setTransactionInfo(transaction: Transaction) {
        NameLabel.text = transaction.Name
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = dateFormatter.string(from: transaction.Date)
        DateLabel.text = "\(date)"
        let amount = transaction.Amount
        AmountLabel.text = "\(amount)"
        AmountLabel.textColor = UIHelpers.getPosNegColorFor(total: amount)
    }
    
    private func addSubviews() {
        let subviews = [NameLabel, DateLabel, AmountLabel]
        subviews.forEach { self.addSubview($0) }
    }
    
    private func anchorSubviews() {
        DateLabel.setBottomAnchor(to: self.centerYAnchor)
        DateLabel.setLeadingAnchor(to: self.leadingAnchor, withPadding: 10)
        
        NameLabel.setTopAnchor(to: self.centerYAnchor)
        NameLabel.setLeadingAnchor(to: DateLabel.leadingAnchor)
        
        AmountLabel.setCenterYAnchor(to: self.centerYAnchor)
        AmountLabel.setTrailingAnchor(to: self.trailingAnchor, withPadding: -10)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
