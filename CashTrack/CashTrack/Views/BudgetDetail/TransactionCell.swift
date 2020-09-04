//
//  TransactionCell.swift
//  CashTrack
//
//  Created by Jake Edwards on 9/2/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

public class TransactionCell : UICollectionViewCell {
    private(set) var NameLabel: UILabel = {
        let label = UILabel()
        label.text = "Transaction"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var AmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .blue
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
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

    private func addSubviews() {
        let subviews = [self.NameLabel, self.AmountLabel]
        subviews.forEach { subview in self.addSubview(subview) }
    }

    private func anchorSubviews() {
        self.NameLabel.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        self.NameLabel.setCenterYAnchor(to: self.centerYAnchor)
        
        self.AmountLabel.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        self.AmountLabel.setCenterYAnchor(to: self.centerYAnchor)
    }
    
    public func setTransactionInfoForCell(with transaction: Transaction) {
        self.NameLabel.text = transaction.Name
        self.AmountLabel.text = "$\(transaction.Amount)"
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
