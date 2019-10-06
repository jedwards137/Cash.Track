//
//  NewTransactionViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/11/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class NewTransactionViewController : UIViewControllerBase {
    private var PageView = NewTransactionPageView()
    public var WalletId : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Transaction"
        self.view.backgroundColor = UIColor(r: 156, g: 175, b: 183)
    }
    
    internal override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor, withPadding: 2*EdgePadding)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor, withPadding: -2*EdgePadding)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.SubmitButton.addTarget(self, action: #selector(submitTransaction), for: .touchUpInside)
    }
    
    @objc private func submitTransaction() {
        let name = PageView.TransactionNameField.getText()
        let transactionType = PageView.TransactionTypeField.getText()
        var amount = PageView.AmountField.getDouble()
        if transactionType == "withdrawal" {
            amount *= -1 // todo move to store logic (later: create repo to do logic)
        }
        let date = PageView.DateField.PickedDate
        
        let addTransactionResult = Store.shared.addTransaction(name: name, amount: amount, transType: .Withdrawal, date: date!, walletId: WalletId)
        if !addTransactionResult { return }
        self.navigationController?.popViewController(animated: true)
    }
}
