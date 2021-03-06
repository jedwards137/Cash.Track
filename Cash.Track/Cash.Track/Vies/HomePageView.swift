//
//  HomePageView.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class HomePageView : UIViewBase {
    private(set) var TotalAmountLabel : UILabel = {
        let label = UILabel()
        label.text = "$0"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 65)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var TransactionsLabel : UILabel = {
        let label = UILabel()
        label.text = "Transactions"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var NewTransactionButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) var TransactionCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    private(set) var TransactionCellId : String = "transactionCellId"
    private(set) var TransactionHeaderId : String = "transactionHeaderId"
    
    override init() {
        super.init()
        self.backgroundColor = .white
    }
    
    internal override func addSubviews() {
        let subviews = [TotalAmountLabel, TransactionsLabel, NewTransactionButton, TransactionCollectionView]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        TotalAmountLabel.setTopAnchor(to: self.safeAreaLayoutGuide.topAnchor)
        TotalAmountLabel.setHeightAnchor(to: 75)
        TotalAmountLabel.setCenterXAnchor(to: self.centerXAnchor)
        
        TransactionsLabel.setTopAnchor(to: TotalAmountLabel.bottomAnchor, withPadding: 2*EdgePadding)
        TransactionsLabel.setHeightAnchor(to: 25)
        TransactionsLabel.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionsLabel.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        NewTransactionButton.setTopAnchor(to: TransactionsLabel.topAnchor)
        NewTransactionButton.setHeightAnchor(to: 25)
        NewTransactionButton.setWidthAnchor(to: 25)
        NewTransactionButton.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        TransactionCollectionView.setTopAnchor(to: NewTransactionButton.bottomAnchor, withPadding: EdgePadding)
        TransactionCollectionView.setBottomAnchor(to: self.bottomAnchor)
        TransactionCollectionView.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionCollectionView.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
