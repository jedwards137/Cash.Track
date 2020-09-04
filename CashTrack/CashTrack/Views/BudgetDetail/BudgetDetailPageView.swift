//
//  BudgetDetailPageView.swift
//  CashTrack
//
//  Created by Jake Edwards on 9/1/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class BudgetDetailPageView: UIViewBase {
    private let OverviewTitle: UILabel = {
        let label = UILabel()
        label.text = "OVERVIEW"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var CurrentPotLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Pot"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var CurrentPotAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var TransactionCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Transactions This Month"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var TransactionCountAmount: UILabel = {
        let label = UILabel()
        label.text = "Transactions This Month"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var AverageTransactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Average Transaction Amount"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var AverageTransactionAmount: UILabel = {
        let label = UILabel()
        label.text = "Average Transaction Amount"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let CashFlowTitle: UILabel = {
        let label = UILabel()
        label.text = "CASH FLOW"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var AllocatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Allocated"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var AllocatedAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let SpentLabel: UILabel = {
        let label = UILabel()
        label.text = "Spent"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var SpentAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var NetAmount: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .blue
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let TransactionsTitle: UILabel = {
        let label = UILabel()
        label.text = "TRANSACTIONS"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) var TransactionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    private(set) var NewTransactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        button.setTitle("New Transaction", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) var EditBudgetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.setTitle("Edit Budget", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init() {
        super.init()
        self.backgroundColor = .white
    }
    
    public func setInfoFor(_ budget: Budget) {
        self.CurrentPotAmount.text = "$\(budget.CurrentPot)"
        self.AverageTransactionAmount.text = "$\(budget.AverageTransactionAmount)"
        self.TransactionCountAmount.text = "\(budget.MonthlyNumberOfTransactions)"

        self.AllocatedAmount.text = "$\(budget.MonthlyAllocation)"
        self.SpentAmount.text = "$\(budget.MonthlyAmountSpent)"
        self.NetAmount.text = "$\(budget.MonthlyAmountRemaining)"
    }
        
    internal override func addSubviews() {
        let subviews = [self.OverviewTitle, self.CurrentPotLabel, self.CurrentPotAmount, self.TransactionCountLabel, self.TransactionCountAmount, self.AverageTransactionLabel, self.AverageTransactionAmount, self.CashFlowTitle, self.AllocatedLabel, self.AllocatedAmount, self.SpentLabel, self.SpentAmount, self.NetAmount, self.TransactionsTitle, self.TransactionsCollectionView, self.NewTransactionButton, self.EditBudgetButton]
        subviews.forEach { subview in self.addSubview(subview) }
    }
    
    internal override func anchorSubviews() {
        anchorOverviewSection()
        anchorCashFlowSection()
        anchorTransactionsSection()
        anchorButtons()
    }
    
    private func anchorOverviewSection() {
        self.OverviewTitle.setTopAnchor(to: self.topAnchor, withPadding: 2*UIValues.EdgePadding)
        self.OverviewTitle.setLeadingAnchor(to: self.leadingAnchor, withPadding: 2*UIValues.EdgePadding)
        
        self.CurrentPotLabel.setTopAnchor(to: self.OverviewTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.CurrentPotLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.CurrentPotAmount.setTopAnchor(to: self.OverviewTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.CurrentPotAmount.setTrailingAnchor(to: self.trailingAnchor, withPadding: -2*UIValues.EdgePadding)
        
        self.AverageTransactionLabel.setTopAnchor(to: self.CurrentPotLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.AverageTransactionLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.AverageTransactionAmount.setTopAnchor(to: self.CurrentPotLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.AverageTransactionAmount.setTrailingAnchor(to: self.CurrentPotAmount.trailingAnchor)
        
        self.TransactionCountLabel.setTopAnchor(to: self.AverageTransactionLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.TransactionCountLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.TransactionCountAmount.setTopAnchor(to: self.AverageTransactionLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.TransactionCountAmount.setTrailingAnchor(to: self.CurrentPotAmount.trailingAnchor)
    }
    
    private func anchorCashFlowSection() {
        self.CashFlowTitle.setTopAnchor(to: self.TransactionCountLabel.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.CashFlowTitle.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.AllocatedLabel.setTopAnchor(to: self.CashFlowTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.AllocatedLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.AllocatedAmount.setTopAnchor(to: self.CashFlowTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.AllocatedAmount.setTrailingAnchor(to: self.centerXAnchor)
        
        self.SpentLabel.setTopAnchor(to: self.AllocatedLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.SpentLabel.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.SpentAmount.setTopAnchor(to: self.AllocatedLabel.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.SpentAmount.setTrailingAnchor(to: self.centerXAnchor)
        
        self.NetAmount.setTopAnchor(to: self.AllocatedLabel.topAnchor)
        self.NetAmount.setBottomAnchor(to: self.SpentLabel.bottomAnchor)
        self.NetAmount.setTrailingAnchor(to: self.CurrentPotAmount.trailingAnchor)
    }
    
    private func anchorTransactionsSection() {
        self.TransactionsTitle.setTopAnchor(to: self.SpentLabel.bottomAnchor, withPadding: 2*UIValues.EdgePadding)
        self.TransactionsTitle.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        
        self.TransactionsCollectionView.setTopAnchor(to: self.TransactionsTitle.bottomAnchor, withPadding: UIValues.EdgePadding)
        self.TransactionsCollectionView.setBottomAnchor(to: self.NewTransactionButton.topAnchor, withPadding: -2*UIValues.EdgePadding)
        self.TransactionsCollectionView.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        self.TransactionsCollectionView.setTrailingAnchor(to: self.CurrentPotAmount.trailingAnchor)
    }
    
    private func anchorButtons() {
        self.NewTransactionButton.setBottomAnchor(to: self.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.NewTransactionButton.setHeightAnchor(to: UIValues.ButtonHeight)
        self.NewTransactionButton.setLeadingAnchor(to: self.OverviewTitle.leadingAnchor)
        self.NewTransactionButton.setTrailingAnchor(to: self.centerXAnchor, withPadding: -UIValues.EdgePadding)
        
        self.EditBudgetButton.setBottomAnchor(to: self.bottomAnchor, withPadding: -2*UIValues.EdgePadding)
        self.EditBudgetButton.setHeightAnchor(to: UIValues.ButtonHeight)
        self.EditBudgetButton.setLeadingAnchor(to: self.centerXAnchor, withPadding: UIValues.EdgePadding)
        self.EditBudgetButton.setTrailingAnchor(to: self.CurrentPotAmount.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
