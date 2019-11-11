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
        for transactionList in TransactionsByDate {
            transactionList.forEach { total += $0.getAdjustedAmount() }
        }
        return total
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
                return true
            }
        }
        TransactionsByDate.append([transactionToAdd])
        sortTransactionGroupsByDate()
        return true
    }
    
    func deleteTransactionAt(index: IndexPath) {
        TransactionsByDate[index.section].remove(at: index.row)
        let needToRemoveSection = TransactionsByDate[index.section].count < 1
        if needToRemoveSection {
            TransactionsByDate.remove(at: index.row)
        }
    }
    
    private func saveTransactionData() {
//        do {
//            let encodedTransactions : Data = try NSKeyedArchiver.archivedData(withRootObject: TransactionsByDate, requiringSecureCoding: true)
//            UserDefaults.standard.set(encodedTransactions, forKey: TransactionDataKey)
//        } catch {
//            print("error")
//        }
        
    }
    
    private func sortTransactionGroupsByDate() {
        let sortedTransactions = TransactionsByDate.sorted(by: { $0.first!.Date.compare($1.first!.Date) == .orderedDescending })
        TransactionsByDate = sortedTransactions
    }
    
    init() {
        //let encodedStoredTransactionData = UserDefaults.standard.data(forKey: TransactionDataKey)
//        let hasStoredTransactions = decodedStoredTransactionData?.count ?? 0 > 0
//        if !hasStoredTransactions {
//            addDummyData()
//            return
//        }
//        TransactionsByDate = decodedStoredTransactionData as! [[Transaction]]
        addDummyData()
    }
    
    private func addDummyData() {
        let transaction1 = Transaction(name: "Paycheck 1", amount: 500, transType: .Deposit, date: Date())
        let transaction2 = Transaction(name: "Paycheck 2", amount: 750, transType: .Deposit, date: Date())
        let transaction3 = Transaction(name: "Rent", amount: 750, transType: .Withdrawal, date: Date())
        let transaction4 = Transaction(name: "Fast Food", amount: 15, transType: .Withdrawal, date: Date())
        let transactions = [transaction1, transaction2, transaction3, transaction4]
        transactions.forEach { addNewTransaction($0) }
    }
}
