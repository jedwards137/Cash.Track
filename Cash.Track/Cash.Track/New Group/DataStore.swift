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
    //weak var AccUpdateDelegate : WalletUpdateDelegate?
    
    //private(set) var WalletData : [Wallet] = []
    private(set) var Transactions : [[Transaction]] = []
    
    func getTransactionsTotal() -> Double {
        var total : Double = 0
        for date in Transactions {
            for transaction in date {
                total += transaction.Amount
            }
        }
        return total
    }
    
    init() {
        
        let t1 = Transaction(name: "pay check 1", amount: 1000, transType: .Deposit, date: Date(timeIntervalSinceNow: 0))
        let t2 = Transaction(name: "pay check 2", amount: 80, transType: .Deposit, date: Date(timeIntervalSinceNow: 0))
        let t3 = Transaction(name: "child support", amount: -25, transType: .Withdrawal, date: Date(timeIntervalSinceNow: 0))
        let ta1 = [t1,t2,t3]
        
        let t7 = Transaction(name: "pay check 1", amount: 1000, transType: .Deposit, date: Date(timeIntervalSince1970: 10000000000000))
        let t8 = Transaction(name: "pay check 2", amount: 70, transType: .Deposit, date: Date(timeIntervalSince1970: 10000000000000))
        let t9 = Transaction(name: "child support", amount: -25, transType: .Withdrawal, date: Date(timeIntervalSince1970: 10000000000000))
        let ta2 = [t7,t8,t9]
        
        let t10 = Transaction(name: "pay check 1", amount: 1000, transType: .Deposit, date: Date(timeIntervalSince1970: 100000000000))
        let t11 = Transaction(name: "pay check 2", amount: 60, transType: .Deposit, date: Date(timeIntervalSince1970: 100000000000))
        let t12 = Transaction(name: "child support", amount: -25, transType: .Withdrawal, date: Date(timeIntervalSince1970: 100000000000))
        let ta3 = [t10,t11,t12]
        
        //let a1 = Wallet(id: 1, name: "Checking", transactions: [t1, t2, t3, t7, t8, t9, t10, t11, t12])
        //WalletData.append(a1)
        
        let t4 = Transaction(name: "pay check 1", amount: 10, transType: .Deposit, date: Date(timeIntervalSince1970: 1000000000))
        let t5 = Transaction(name: "pay check 2", amount: 50, transType: .Deposit, date: Date(timeIntervalSince1970: 1000000000))
        let t6 = Transaction(name: "child support", amount: -250, transType: .Withdrawal, date: Date(timeIntervalSince1970: 1000000000))
        let ta4 = [t4,t5,t6]
        
        Transactions.append(ta1)
        Transactions.append(ta2)
        Transactions.append(ta3)
        Transactions.append(ta4)
        
//        Transactions = Transactions.sorted(by: { $0.Date > $1.Date })
//        for t in Transactions {
//            print(t.Date)
//        }
        //let a2 = Wallet(id: 2, name: "savings", transactions: [t4, t5, t6])
        //WalletData.append(a2)

        //AccUpdateDelegate?.didUpdateAccount()
    }
    
//    public func addTransaction(name: String, amount: Double, transType: TransactionType, date: Date, walletId: Int) -> Bool {
//        let dataIsValid = name.count > 0 && amount > 0.0
//        let returnedWallet = getWalletFor(walletId: walletId)
//        let returnedWalletIsValid = returnedWallet != nil
//        if returnedWalletIsValid && dataIsValid {
//            let transaction = Transaction(name: name, amount: amount, transType: transType, date: date)
//            WalletData.removeAll(where: {
//                $0.WalletId == walletId
//            })
//            returnedWallet?.Transactions.append(transaction)
//            WalletData.append(returnedWallet!)
//            return true
//        }
//        return false
//    }
    
//    public func addWalletWith(name: String) -> Bool {
//        let nameHasCharacters = name.count > 0
//        if nameHasCharacters {
//            let wallet = Wallet(id: 3, name: name, transactions: [])
//            WalletData.append(wallet)
//
//            let returnedWallet = getWalletFor(walletId: wallet.WalletId)
//            let returnedWalletIsValid = returnedWallet != nil
//            if returnedWalletIsValid { return true }
//        }
//        return false
//    }
//
//    public func getWalletFor(walletId: Int) -> Wallet? {
//        let account = WalletData.first(where: { $0.WalletId == walletId })
//        return account
//    }
    
//    public func getTotalForAllWallets() -> Double {
//        var amount : Double = 0
//        for wallet in WalletData {
//            amount += wallet.GetTotalValue()
//        }
//        return amount
//    }
}
