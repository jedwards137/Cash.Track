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
            cleanTransactionDate()
            sortTransactionGroupsByDate()
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
    
    public func getTransactionAt(index: IndexPath) -> Transaction {
        let transaction = TransactionsByDate[index.section][index.row]
        return transaction
    }
    
    public func addNewTransaction(_ transactionToAdd: Transaction) {
        var tempTransactions = TransactionsByDate
        let transactionGroupsExist = tempTransactions.count > 0
        if transactionGroupsExist {
            for i in 0..<tempTransactions.count {
                let transactionsExistInGroup = tempTransactions[i].count > 0
                if transactionsExistInGroup {
                    let dateForGroup = tempTransactions[i].first!.Date
                    let isCorrectTransactionGroupToAddIn = dateForGroup.equaltTo(transactionToAdd.Date)
                    if isCorrectTransactionGroupToAddIn {
                        tempTransactions[i].append(transactionToAdd)
                        TransactionsByDate = tempTransactions
                    }
                }
            }
        }
        else {
            tempTransactions.append([transactionToAdd])
            TransactionsByDate = tempTransactions
        }
    }
    
    public func deleteTransactionAt(index: IndexPath) {
        TransactionsByDate[index.section].remove(at: index.row)
    }
    
    init() {
        loadTransactionData()
        //addDummyData()
        for group in TransactionsByDate {
            for trn in group {
                print(trn.Name)
            }
        }
        //addDummyData()
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
    
    private func cleanTransactionDate() {
        if TransactionsByDate.count == 0 { return }
        var i = 0
        while i < TransactionsByDate.count {
            if TransactionsByDate[i].count == 0 {
                TransactionsByDate.remove(at: i)
                continue
            }
            i += 1
        }
    }
    
    private func sortTransactionGroupsByDate() {
        if TransactionsByDate.count > 1 {
            var sortedGroups = TransactionsByDate.sorted(by: { $0.first!.Date.compare($1.first!.Date) == .orderedDescending
            })
            for i in 0..<sortedGroups.count {
                if sortedGroups[i].count > 1 {
                    let sortedTransactions = sortedGroups[i].sorted(by: {
                        $0.Date.compare($1.Date) == .orderedDescending
                    })
                    sortedGroups[i] = sortedTransactions
                }
            }
            TransactionsByDate = sortedGroups
        }
    }
    
    private func addDummyData() {
        let transaction1 = Transaction(name: "Paycheck 1", amount: 500.78, transType: .Deposit, date: Date())
        let transaction2 = Transaction(name: "Paycheck 2", amount: 750, transType: .Deposit, date: Date())
        let transaction3 = Transaction(name: "Rent", amount: 750, transType: .Withdrawal, date: Date())
        let transaction4 = Transaction(name: "Fast Food", amount: 15.88, transType: .Withdrawal, date: Date())
        let transactions = [transaction1, transaction2, transaction3, transaction4]
        transactions.forEach { addNewTransaction($0) }
    }
}
