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
    private var DummyDataIsShown : Bool = false
    
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
        if DummyDataIsShown {
            TransactionsByDate = []
        }
        
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
        if !DummyDataIsShown {
            saveTransactionData()
        }
        return transactionAdded
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
        DummyDataIsShown = false //true
    }
}
