//
//  Budget.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import Foundation

public class Budget {
    private(set) var Name: String
    private(set) var MonthlyAllocation: Double
    private(set) var PreviousPot: Double
    private(set) var TransactionList: [Transaction]
    
    var MonthlyAmountSpent: Double {
        let transactionsForThisBudget = DataStore.shared.getTransactionsForBudgetForCurrentMonth(budgetName: self.Name)
        let amountSpent = transactionsForThisBudget.sum({ $0.Amount })
        return amountSpent
    }
    var MonthlyAmountRemaining: Double {
        let amountRemaining = self.MonthlyAllocation - self.MonthlyAmountSpent
        return amountRemaining
    }
    var PercentOfMonthlyAllocationSpent: Float {
        let percentOfMonthlyAllocationSpent: Float = Float(MonthlyAmountSpent / self.MonthlyAllocation)
        return percentOfMonthlyAllocationSpent
    }
    var CurrentPot: Double {
        let currentPot = self.PreviousPot + (self.MonthlyAllocation - self.MonthlyAmountSpent)
        return currentPot
    }
    var MonthlyNumberOfTransactions: Int {
        let transactionsForBudgetForCurrentMonth = DataStore.shared.getTransactionsForBudgetForCurrentMonth(budgetName: self.Name)
        let monthlyNumberOfTransactions = transactionsForBudgetForCurrentMonth.count
        return monthlyNumberOfTransactions
    }
    var AverageTransactionAmount: Double {
        let averageTransactionAmount = self.MonthlyAmountSpent / Double(MonthlyNumberOfTransactions)
        let avergageTransactionAmountIsValid = averageTransactionAmount > 0 ? averageTransactionAmount : 0
        return avergageTransactionAmountIsValid
    }
    
    public init(name: String, monthlyAllocation: Double, previousPot: Double = 0) {
        self.Name = name
        self.MonthlyAllocation = monthlyAllocation
        self.PreviousPot = previousPot
        //self.TransactionList = []
    }
    
    public func reconcileAmounts() {
        let currentMonthRemainingAmount = self.MonthlyAllocation - self.MonthlyAmountSpent
        self.PreviousPot += currentMonthRemainingAmount
    }
    
    public func updateName(with newName: String) {
        self.Name = newName
    }
    
    public func updateMonthlyAllocation(with newMonthlyAllocation: Double) {
        self.MonthlyAllocation = newMonthlyAllocation
    }
    
    public func updatePreviousPot(with newPreviousPot: Double) {
        self.PreviousPot = newPreviousPot
    }
}
