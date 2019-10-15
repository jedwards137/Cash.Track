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
    
    func getTotalForAllTransactions() -> Double {
        var total : Double = 0
        for dateGroup in TransactionsByDate {
            for transaction in dateGroup {
                total += transaction.getAdjustedAmount()
            }
        }
        return total
    }
    
    func addNewTransaction(_ transaction: Transaction) -> Bool {
        var transactionAdded = false
        for i in 0..<TransactionsByDate.count {
            let dateForCurrentGroup = TransactionsByDate[i].first?.Date
            let correspondingDateGroupFound = dateForCurrentGroup!.compareByDayMonthYear(transaction.Date)
            if correspondingDateGroupFound {
                let transactionAlreadyExistsInDateGroup = TransactionsByDate[i].contains(where: { transactionInArray in transactionInArray.Name == transaction.Name })
                if transactionAlreadyExistsInDateGroup {
                    transactionAdded = true
                    break
                }
                TransactionsByDate[i].insert(transaction, at: 0)
                transactionAdded = true
            }
        }
        if !transactionAdded {
            TransactionsByDate.append([transaction])
            transactionAdded = true
            sortTransactionGroupsByDate()
        }
        saveTransactionData()
        return transactionAdded
    }
    
    private func saveTransactionData() {
        UserDefaults.standard.set(TransactionsByDate, forKey: TransactionDataKey)
    }
    
    private func sortTransactionGroupsByDate() {
        let sortedTransactions = TransactionsByDate.sorted(by: { $0.first!.Date.compare($1.first!.Date) == .orderedDescending })
        TransactionsByDate = sortedTransactions
    }
    
    init() {
        let storedTransactionData = UserDefaults.standard.array(forKey: TransactionDataKey)
        let hasStoredTransactions = storedTransactionData?.count ?? 0 > 0
        if !hasStoredTransactions { return }
        TransactionsByDate = storedTransactionData as! [[Transaction]]
    }
}
