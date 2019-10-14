//
//  HomePageView.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class HomePageView : UIViewBase {
    public let BackgroundView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    public let TotalAmountLabel : UILabel = {
        let label = UILabel()
        label.text = "$0"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 75)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public let TransactionsLabel : UILabel = {
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
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    public let TransactionCollectionView : UICollectionView = {
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
        let subviews = [BackgroundView, TotalAmountLabel, TransactionsLabel, NewTransactionButton, TransactionCollectionView]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        BackgroundView.setTopAnchor(to: self.topAnchor)
        BackgroundView.setBottomAnchor(to: TransactionsLabel.topAnchor, withPadding: -EdgePadding)
        BackgroundView.setLeadingAnchor(to: self.leadingAnchor)
        BackgroundView.setTrailingAnchor(to: self.trailingAnchor)
        
        TotalAmountLabel.setTopAnchor(to: self.safeAreaLayoutGuide.topAnchor, withPadding: 2*EdgePadding)
        TotalAmountLabel.setHeightAnchor(to: 75)
        TotalAmountLabel.setCenterXAnchor(to: self.centerXAnchor)
        
        TransactionsLabel.setTopAnchor(to: TotalAmountLabel.bottomAnchor, withPadding: 2*EdgePadding)
        TransactionsLabel.setHeightAnchor(to: 25)
        TransactionsLabel.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionsLabel.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        NewTransactionButton.setTopAnchor(to: TransactionsLabel.topAnchor)
        NewTransactionButton.setBottomAnchor(to: TransactionsLabel.bottomAnchor)
        NewTransactionButton.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
        
        TransactionCollectionView.setTopAnchor(to: NewTransactionButton.bottomAnchor, withPadding: 2*EdgePadding)
        TransactionCollectionView.setBottomAnchor(to: self.bottomAnchor)
        TransactionCollectionView.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*EdgePadding)
        TransactionCollectionView.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*EdgePadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
