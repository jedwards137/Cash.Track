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
    private let TransactionDataKey : String = "transactionData"
    
    func getTotalForAllTransactions() -> String {
        var total : Double = 0
        for transactionList in TransactionsByDate {
            transactionList.forEach { total += $0.getAdjustedAmount() }
        }
        return total.round()
    }
    
    func getTransactionAt(index: IndexPath) -> Transaction {
        let transaction = TransactionsByDate[index.section][index.row]
        return transaction
    }
    
    func addNewTransaction(_ transactionToAdd: Transaction) -> Bool {
        for i in 0..<TransactionsByDate.count {
            let transactionGroup = TransactionsByDate[i]
            let dateForGroup = transactionGroup.first!.Date
            let isCorrectTransactionGroupToAddIn = dateForGroup.equaltTo(transactionToAdd.Date)
            if isCorrectTransactionGroupToAddIn {
                for transaction in transactionGroup {
                    if transaction.Date.extendedEqualTo(transactionToAdd.Date) && transaction.Name == transactionToAdd.Name {
                        return false
                    }
                }
                TransactionsByDate[i].append(transactionToAdd)
                sortTransactionGroupsByDate()
                saveTransactionData()
                return true
            }
        }
        TransactionsByDate.append([transactionToAdd])
        sortTransactionGroupsByDate()
        saveTransactionData()
        return true
    }
    
    func deleteTransactionAt(index: IndexPath) {
        TransactionsByDate[index.section].remove(at: index.row)
        let needToRemoveSection = TransactionsByDate[index.section].count < 1
        if needToRemoveSection {
            TransactionsByDate.remove(at: index.row)
        }
        saveTransactionData()
    }
    
    private func saveTransactionData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(TransactionsByDate) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "transactions")
        }
    }
    
    private func loadTransactionDate() {
        if let savedTransactions = UserDefaults.standard.object(forKey: "transactions") as? Data {
            let decoder = JSONDecoder()
            if let loadedTransactions = try? decoder.decode([[Transaction]].self, from: savedTransactions) {
                print(loadedTransactions)
                TransactionsByDate = loadedTransactions
            }
        }
    }
    
    private func sortTransactionGroupsByDate() {
        let sortedTransactions = TransactionsByDate.sorted(by: { $0.first!.Date.compare($1.first!.Date) == .orderedDescending })
        TransactionsByDate = sortedTransactions
    }
    
    init() {
        loadTransactionDate()
    }
}
