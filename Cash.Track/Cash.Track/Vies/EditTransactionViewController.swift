//
//  EditTransactionViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 11/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class EditTransactionViewController: UIViewControllerBase {
    private var PageView = EditTransactionPageView()
    private var IndexPath : IndexPath!
        
    public func setTransactionLocation(at indexPath: IndexPath) {
        IndexPath = indexPath
        let transaction = DataStore.shared.getTransactionAt(indexPath: IndexPath)
        PageView.setTransactionInfo(with: transaction)
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        self.title = "Edit Transaction"
    }
    
    internal override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.topAnchor)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.UpdateButton.addTarget(self, action: #selector(submitTransaction), for: .touchUpInside)
        PageView.DeleteButton.addTarget(self, action: #selector(deleteTransaction), for: .touchUpInside)
    }
        
    @objc private func submitTransaction() {
        let allValuesExist = PageView.TransactionNameField.hasText() && PageView.TransactionTypeField.hasText() && PageView.AmountField.hasDouble()
        if !allValuesExist { return }
        
        let name = PageView.TransactionNameField.getText()
        let amount = PageView.AmountField.getDouble()
        let transactionType = PageView.TransactionTypeField.getText()
        let transactionTypeEnum = TransactionType(rawValue: transactionType)!
        let date = PageView.DateTimeField.DatePicker.date
        
        let transactionToAdd = Transaction(name: name, amount: amount, transType: transactionTypeEnum, date: date)
        DataStore.shared.deleteTransactionAt(index: IndexPath)
        DataStore.shared.addNewTransaction(transactionToAdd)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteTransaction() {
        DataStore.shared.deleteTransactionAt(index: IndexPath)
        self.navigationController?.popViewController(animated: true)
    }
}

