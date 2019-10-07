//
//  Store.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation

public class DataStore {
    static let shared = DataStore()
    
    private(set) var TransactionsByDate : [[Transaction]] = []
    
    func getTotalForAllTransactions() -> Double {
        var total : Double = 0
        for dateGroup in TransactionsByDate {
            for transaction in dateGroup {
                total += transaction.Amount
            }
        }
        return total
    }
    
    func addNewTransaction(_ transaction: Transaction) {
        var transactionAdded = false
        for i in 0..<TransactionsByDate.count {
            let dateForCurrentGroup = TransactionsByDate[i].first?.Date
            let correspondingDateGroupFound = dateForCurrentGroup!.compareByYearAndDay(transaction.Date)
            if correspondingDateGroupFound {
                TransactionsByDate[i].insert(transaction, at: 0)
                transactionAdded = true
            }
        }
        if !transactionAdded {
            TransactionsByDate.append([transaction])
            sortTransactionGroupsByDate()
        }
    }
    
    private func sortTransactionGroupsByDate() {
        let sortedTransactions = TransactionsByDate.sorted(by: { $0.first!.Date.compare($1.first!.Date) == .orderedDescending })
        TransactionsByDate = sortedTransactions
    }
    
    init() {
        let t1 = Transaction(name: "pay check 1", amount: 1000, transType: .Deposit, date: Date(timeIntervalSinceNow: 0))
        addNewTransaction(t1)
        let t2 = Transaction(name: "pay check 2", amount: 80, transType: .Deposit, date: Date(timeIntervalSinceNow: 0))
        addNewTransaction(t2)
        let t3 = Transaction(name: "child support", amount: -25, transType: .Withdrawal, date: Date(timeIntervalSinceNow: 0))
        addNewTransaction(t3)
        
        let t7 = Transaction(name: "pay check 1", amount: 1000, transType: .Deposit, date: Date(timeIntervalSince1970: 10000000000000))
        addNewTransaction(t7)
        let t8 = Transaction(name: "pay check 2", amount: 70, transType: .Deposit, date: Date(timeIntervalSince1970: 10000000000000))
        addNewTransaction(t8)
        let t9 = Transaction(name: "child support", amount: -25, transType: .Withdrawal, date: Date(timeIntervalSince1970: 10000000000000))
        addNewTransaction(t9)
        
        let t10 = Transaction(name: "pay check 1", amount: 1000, transType: .Deposit, date: Date(timeIntervalSince1970: 100000000000))
        addNewTransaction(t10)
        let t11 = Transaction(name: "pay check 2", amount: 60, transType: .Deposit, date: Date(timeIntervalSince1970: 100000000000))
        addNewTransaction(t11)
        let t12 = Transaction(name: "child support", amount: -25, transType: .Withdrawal, date: Date(timeIntervalSince1970: 100000000000))
        addNewTransaction(t12)
        
        let t4 = Transaction(name: "pay check 1", amount: 10, transType: .Deposit, date: Date(timeIntervalSince1970: 1000000000))
        addNewTransaction(t4)
        let t5 = Transaction(name: "pay check 2", amount: 50, transType: .Deposit, date: Date(timeIntervalSince1970: 1000000000))
        addNewTransaction(t5)
        let t6 = Transaction(name: "child support", amount: -250, transType: .Withdrawal, date: Date(timeIntervalSince1970: 1000000000))
        addNewTransaction(t6)
    }
}
