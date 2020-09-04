//
//  EditTransactionViewController.swift
//  CashTrack
//
//  Created by Jake Edwards on 9/3/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class EditTransactionViewController: UIViewControllerBase {
    private var PageView = EditTransactionPageView()
    private var TransactionIndex: Int!
    private var BudgetIndex: Int!
    
    override func setupNavBar() {
        super.setupNavBar()
        self.title = "Edit Budget"
    }
    
    public func setInfoForTransaction(at index: Int, forBudgetIndex budgetIndex: Int) {
        self.TransactionIndex = index
        self.BudgetIndex = budgetIndex
        
        let currentBudget = DataStore.shared.getBudget(at: budgetIndex)
        let transaction = currentBudget.getTransaction(at: index)
        PageView.setInfoFor(transaction)
    }
    
    override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setBottomAnchor(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.UpdateButton.addTarget(self, action: #selector(updateTransactionAndPop), for: .touchUpInside)
        PageView.DeleteButton.addTarget(self, action: #selector(deleteTransactionAndPop), for: .touchUpInside)
    }
    
    @objc private func updateTransactionAndPop() {
        let allValuesExist = PageView.NameField.hasText() && PageView.AmountField.hasDouble() && PageView.DateField.hasText()
        if !allValuesExist { return }
        
        let newName = PageView.NameField.getText()
        let newAmount = PageView.AmountField.getDouble()
        let newDate = PageView.DateField.DatePicker.date
        
        DataStore.shared.updateTransactionWith(newName, newAmount, newDate, forTransactionIndex: self.TransactionIndex, forBudgetIndex: self.BudgetIndex)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteTransactionAndPop() {
        let currentBudget = DataStore.shared.getBudget(at: self.BudgetIndex)
        currentBudget.deleteTransaction(at: self.TransactionIndex)

        self.navigationController?.popViewController(animated: true)
    }
}
