//
//  DataStore.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import Foundation

public class DataStore {
    static let shared = DataStore()
    //weak var DataUpdateDelegate : DataUpdateDelegate?
    
    private var BudgetList: [Budget] = []
    private var TransactionList: [Transaction] = []
    private(set) var CurrentMonth: Int
    
    init() {
        self.CurrentMonth = 9
        
        let b1 = Budget(name: "Savings", monthlyAllocation: 400)
        let b2 = Budget(name: "Fun", monthlyAllocation: 800)
        let b3 = Budget(name: "Necessities", monthlyAllocation: 800)
        BudgetList = [b1, b2, b3]
        
        let date = Date()
        let t1 = Transaction(name: "rent", amount: 200, date: date, budgetName: "Necessities")
        let t2 = Transaction(name: "car", amount: 400, date: date, budgetName: "Fun")
        let t3 = Transaction(name: "401k", amount: 300, date: date, budgetName: "Savings")
        TransactionList = [t1, t2, t3]
    }
    
    public func transitionBudgetsToNextMonth() {
        for budget in self.BudgetList {
            budget.reconcileAmounts()
        }
        self.CurrentMonth += 1
    }
    
    public func addNewBudget(_ budget: Budget) {
        self.BudgetList.append(budget)
    }
    
    public func validateNewBudgetNameIsUnique(_ newName: String) -> Bool {
        for budget in self.BudgetList {
            let budgetNameAlreadyExists = budget.Name == newName
            if budgetNameAlreadyExists { return false }
        }
        
        return true
    }
    
    public func updateBudget(at index: Int, name: String, monthlyAllocation: Double, previousPot: Double) {
        let oldBudgetName = self.BudgetList[index].Name
        self.TransactionList.filter {$0.BudgetName == oldBudgetName}.forEach { $0.updateBudgetName(with: name) }
        
        self.BudgetList[index].updateName(with: name)
        self.BudgetList[index].updateMonthlyAllocation(with: monthlyAllocation)
        self.BudgetList[index].updatePreviousPot(with: previousPot)
    }
    
    public func deleteBudget(at index: Int) {
        let budgetName = self.BudgetList[index].Name
        self.TransactionList.removeAll(where: { $0.BudgetName == budgetName })
        self.BudgetList.remove(at: index)
    }
    
    public func getBudget(at index: Int) -> Budget {
        let budgetForIndex = self.BudgetList[index]
        return budgetForIndex
    }
    
    public func getNumberOfBudgets() -> Int {
        let numberOfBudgets = self.BudgetList.count
        return numberOfBudgets
    }
    
    public func getTotalSpentForAllBudgets() -> Double {
        let totalSpent = DataStore.shared.BudgetList.sum({ $0.MonthlyAmountSpent })
        return totalSpent
    }
    
    public func getTotalAllocatedForAllBudgets() -> Double {
        let totalAllocated = DataStore.shared.BudgetList.sum({ $0.MonthlyAllocation })
        return totalAllocated
    }
    
    public func getToalCurrentPotForAllBudgets() -> Double {
        let currentPot = DataStore.shared.BudgetList.sum({ $0.CurrentPot })
        return currentPot
    }
    
    public func getTransactionsForBudgetForCurrentMonth(budgetName: String) -> [Transaction] {
        let transactionsForThisBudget = self.TransactionList.filter({ $0.BudgetName == budgetName && $0.Date.getComponents()["month"] == self.CurrentMonth })
        return transactionsForThisBudget
    }
    
    public func getTransaction(at index: Int) -> Transaction {
        let transactionForIndex = self.TransactionList[index]
        return transactionForIndex
    }
    
    public func deleteTransaction(at index: Int) {
        self.TransactionList.remove(at: index)
    }
}
