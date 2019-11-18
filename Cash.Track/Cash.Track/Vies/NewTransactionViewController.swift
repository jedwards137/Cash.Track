//
//  NewTransactionViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewControllerBase {
    private var PageView = NewTransactionPageView()
    
    override func setupNavBar() {
        super.setupNavBar()
        self.title = "New Transaction"
    }
    
    internal override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.topAnchor)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.SubmitButton.addTarget(self, action: #selector(submitTransaction), for: .touchUpInside)
    }
        
    @objc private func submitTransaction() {
        let allValuesExist = PageView.TransactionNameField.hasText() && PageView.TransactionTypeField.hasText() && PageView.AmountField.hasDouble()
        if !allValuesExist { return }
        
        let name = PageView.TransactionNameField.getText()
        let category = PageView.TransactionCategoryField.getText()
        let amount = PageView.AmountField.getDouble()
        let transactionType = PageView.TransactionTypeField.getText()
        let transactionTypeEnum = TransactionType(rawValue: transactionType)!
        let date = PageView.DateTimeField.DatePicker.date
        
        let transactionToAdd = Transaction(name: name, amount: amount, transType: transactionTypeEnum, category: category, date: date)
        DataStore.shared.addNewTransaction(transactionToAdd)
        self.navigationController?.popViewController(animated: true)
    }
}
