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
    
    private var TransactionsByDate : [[Transaction]] = [] {
        didSet {
            saveTransactionData()
        }
    }
    private let TransactionDataKey : String = "transactionData"
    
    public func getTotalForAllTransactions() -> String {
        var total : Double = 0
        for transactionGroup in TransactionsByDate {
            transactionGroup.forEach { total += $0.getAdjustedAmount() }
        }
        let roundedTotal = total.round()
        return roundedTotal
    }
    
    public func getNumberOfTransactionGroups() -> Int {
        let numberOfGroups = TransactionsByDate.count
        return numberOfGroups
    }
    
    public func getNumberOfTransactionsInGroup(index: Int) -> Int {
        let numberOfTransactionsInGroup = TransactionsByDate[index].count
        return numberOfTransactionsInGroup
    }
    
    public func getTransactionAt(indexPath: IndexPath) -> Transaction {
        let transaction = TransactionsByDate[indexPath.section][indexPath.row]
        return transaction
    }
    
    public func getDateForTransactionInGroup(index: Int) -> Date {
        let dateForGroup = TransactionsByDate[index].first!.Date
        return dateForGroup
    }
    
    public func addNewTransaction(_ transactionToAdd: Transaction) {
        var tempTransactions = TransactionsByDate
        for i in 0..<tempTransactions.count {
            let dateForGroup = tempTransactions[i].first!.Date
            let isCorrectTransactionGroupToAddIn = dateForGroup.equaltTo(transactionToAdd.Date)
            if isCorrectTransactionGroupToAddIn {
                tempTransactions[i].append(transactionToAdd)
                overwriteWithTempData(tempTransactions)
                return
            }
        }
        tempTransactions.append([transactionToAdd])
        overwriteWithTempData(tempTransactions)
    }
    
    public func deleteTransactionAt(index: IndexPath) {
        var tempTransactions = TransactionsByDate
        tempTransactions[index.section].remove(at: index.row)
        overwriteWithTempData(tempTransactions)
    }
    
    init() {
        loadTransactionData()
        //addDummyData()
    }
    
    private func overwriteWithTempData(_ tempTransactions: [[Transaction]]) {
        var tempTransactionData = cleanTransactionData(for: tempTransactions)
        tempTransactionData = sortTransactionGroupsByDate(for: tempTransactionData)
        TransactionsByDate = tempTransactionData
    }
    
    private func saveTransactionData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(TransactionsByDate) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "transactions")
        }
    }
    
    private func loadTransactionData() {
        if let savedTransactions = UserDefaults.standard.object(forKey: "transactions") as? Data {
            let decoder = JSONDecoder()
            if let loadedTransactions = try? decoder.decode([[Transaction]].self, from: savedTransactions) {
                TransactionsByDate = loadedTransactions
            }
        }
    }
    
    private func cleanTransactionData(for transactions: [[Transaction]]) -> [[Transaction]] {
        var tempTransactions = transactions
        if tempTransactions.count == 0 { return tempTransactions}
        var i = 0
        while i < tempTransactions.count {
            if tempTransactions[i].count == 0 {
                tempTransactions.remove(at: i)
                continue
            }
            i += 1
        }
        return tempTransactions
    }
    
    private func sortTransactionGroupsByDate(for transactions: [[Transaction]]) -> [[Transaction]] {
        var tempTransactions = transactions
        tempTransactions = tempTransactions.sorted(by: { $0.first!.Date.compare($1.first!.Date) == .orderedDescending
        })
        for i in 0..<tempTransactions.count {
            let sortedTransactions = tempTransactions[i].sorted(by: {
                $0.Date.compare($1.Date) == .orderedDescending
            })
            tempTransactions[i] = sortedTransactions
        }
        return tempTransactions
    }
    
    private func addDummyData() {
        let transaction1 = Transaction(name: "Paycheck 1", amount: 500.78, transType: .Deposit, category: "Paycheck", date: Date())
        let transaction2 = Transaction(name: "Paycheck 2", amount: 750, transType: .Deposit, category: "Paycheck", date: Date())
        let transaction3 = Transaction(name: "Rent", amount: 750, transType: .Withdrawal, category: "Rent", date: Date())
        let transaction4 = Transaction(name: "Fast Food", amount: 15.88, transType: .Withdrawal, category: "Food", date: Date())
        let transactions = [transaction1, transaction2, transaction3, transaction4]
        transactions.forEach { addNewTransaction($0) }
    }
}
