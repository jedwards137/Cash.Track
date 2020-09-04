//
//  EditBudgetViewController.swift
//  CashTrack
//
//  Created by Jake Edwards on 9/1/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class EditBudgetViewController: UIViewControllerBase {
    private var PageView = EditBudgetPageView()
    private var BudgetIndex: Int!
    
    override func setupNavBar() {
        super.setupNavBar()
        self.title = "Edit Budget"
    }
    
    public func setInfoForBudget(at index: Int) {
        self.BudgetIndex = index
        let budget = DataStore.shared.getBudget(at: index)
        PageView.setInfoFor(budget)
    }
    
    override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setBottomAnchor(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.UpdateButton.addTarget(self, action: #selector(updateBudgetAndPop), for: .touchUpInside)
        PageView.DeleteButton.addTarget(self, action: #selector(deleteBudgetAndPop), for: .touchUpInside)
    }
    
    @objc private func updateBudgetAndPop() {
        let allValuesExist = PageView.NameField.hasText() && PageView.MonthlyAllocationField.hasText()
        if !allValuesExist { return }
        
        let name = PageView.NameField.getText()
        let monthlyAllocation = PageView.MonthlyAllocationField.getDouble()
        let previousPot = PageView.PreviousPotField.getDouble()
        
        DataStore.shared.updateBudget(at: self.BudgetIndex, newName: name, newMonthlyAllocation: monthlyAllocation, newPreviousPot: previousPot)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteBudgetAndPop() {
        DataStore.shared.deleteBudget(at: self.BudgetIndex)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
