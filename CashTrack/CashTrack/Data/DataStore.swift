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
    
    private var BudgetList: [Budget] = []
    private(set) var CurrentMonth: Int
    
    init() {
        self.CurrentMonth = 9
        
        let b1 = Budget(name: "Savings", monthlyAllocation: 400)
        let b2 = Budget(name: "Fun", monthlyAllocation: 800)
        let b3 = Budget(name: "Necessities", monthlyAllocation: 800)
        BudgetList = [b1, b2, b3]
        
        let date = Date()
        let t1 = Transaction(name: "rent", amount: 200, date: date)
        b3.addTransaction(t1)
        let t2 = Transaction(name: "car", amount: 400, date: date)
        b2.addTransaction(t2)
        let t3 = Transaction(name: "401k", amount: 300, date: date)
        b1.addTransaction(t3)
    }
    
    public func transitionBudgetsToNextMonth() {
        for budget in self.BudgetList {
            budget.reconcileAmounts()
        }
        self.CurrentMonth += 1
    }
    
    public func updateTransactionWith(_ newName: String, _ newAmount: Double, _ newDate: Date, forTransactionIndex transactionIndex: Int, forBudgetIndex budgetIndex: Int) {
        self.BudgetList[budgetIndex].updateTransactionWith(newName, newAmount, newDate, forTransactionIndex: transactionIndex)
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
    
    public func updateBudget(at index: Int, newName: String, newMonthlyAllocation: Double, newPreviousPot: Double) {
        self.BudgetList[index].updateValuesWith(newName, newMonthlyAllocation, newPreviousPot)
    }
    
    public func deleteBudget(at index: Int) {
        self.BudgetList.remove(at: index)
    }
    
    public func getBudget(at index: Int) -> Budget {
        let budgetAtIndex = self.BudgetList[index]
        return budgetAtIndex
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
    
    public func getTotalRemainingForAllBudgets() -> Double {
        let totalRemainingForAllBudgets = getTotalAllocatedForAllBudgets() - getTotalSpentForAllBudgets()
        return totalRemainingForAllBudgets
    }
}
