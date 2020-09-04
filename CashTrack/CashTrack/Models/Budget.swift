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
        let transactionsForCurrentMonth = self.TransactionList.filter({ $0.Date.getComponents()["month"] == DataStore.shared.CurrentMonth })
        let monthlyAmountSpent = transactionsForCurrentMonth.sum({ $0.Amount })
        return monthlyAmountSpent
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
        let currentPot = self.PreviousPot + self.MonthlyAmountRemaining
        return currentPot
    }
    var MonthlyNumberOfTransactions: Int {
        let monthlyNumberOfTransactions = self.TransactionList.count
        return monthlyNumberOfTransactions
    }
    var MonthlyAverageTransactionAmount: Double {
        let averageTransactionAmount = self.MonthlyAmountSpent / Double(MonthlyNumberOfTransactions)
        let avergageTransactionAmountIsValid = averageTransactionAmount > 0 ? averageTransactionAmount : 0
        return avergageTransactionAmountIsValid
    }
    
    public init(name: String, monthlyAllocation: Double, previousPot: Double = 0) {
        self.Name = name
        self.MonthlyAllocation = monthlyAllocation
        self.PreviousPot = previousPot
        self.TransactionList = []
    }
    
    public func reconcileAmounts() {
        let remainingAmountForCurrentMonth = self.MonthlyAllocation - self.MonthlyAmountSpent
        self.PreviousPot += remainingAmountForCurrentMonth
    }
    
    public func updateValuesWith(_ newName: String, _ newMonthlyAllocation: Double, _ newPreviousPot: Double) {
        self.Name = newName
        self.MonthlyAllocation = newMonthlyAllocation
        self.PreviousPot = newPreviousPot
    }
    
    public func addTransaction(_ transaction: Transaction) {
        self.TransactionList.append(transaction)
    }
    
    public func getTransaction(at index: Int) -> Transaction {
        let transactionAtIndex = self.TransactionList[index]
        return transactionAtIndex
    }
    
    public func deleteTransaction(at index: Int) {
        self.TransactionList.remove(at: index)
    }
    
    public func updateTransactionWith(_ newName: String, _ newAmount: Double, _ newDate: Date, forTransactionIndex index: Int) {
        self.TransactionList[index].updateValuesWith(newName, newAmount, newDate)
    }
}
