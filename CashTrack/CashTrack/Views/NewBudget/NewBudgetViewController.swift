//
//  NewBudgetViewController.swift
//  CashTrack
//
//  Created by Jake Edwards on 8/14/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class NewBudgetViewController: UIViewControllerBase {
    private var PageView = NewBudgetPageView()
    
    override func setupNavBar() {
        super.setupNavBar()
        self.title = "New Budget"
    }
    
    override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setBottomAnchor(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.SubmitButton.addTarget(self, action: #selector(popToBudgetsViewController), for: .touchUpInside)
    }
    
    @objc func popToBudgetsViewController() {
        let allValuesExist = PageView.NameField.hasText() && PageView.MonthlyAllocationField.hasDouble()
        if !allValuesExist { return }
        
        let name = PageView.NameField.getText()
        let nameIsUnique = DataStore.shared.validateNewBudgetNameIsUnique(name)
        if !nameIsUnique { return }
        
        let monthlyAllocation = PageView.MonthlyAllocationField.getDouble()
        let previousPot = PageView.PreviousPotField.getDouble()
        
        let budgetToAdd = Budget(name: name, monthlyAllocation: monthlyAllocation, previousPot: previousPot)
        DataStore.shared.addNewBudget(budgetToAdd)
        
        self.navigationController?.popViewController(animated: true)
    }
}
