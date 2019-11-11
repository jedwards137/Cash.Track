//
//  Transaction.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation

public class Transaction {
    private(set) var Name : String
    private(set) var Amount : Double
    private(set) var TransType : TransactionType
    private(set) var Date : Date
    
    public init(name: String, amount: Double, transType: TransactionType, date: Date) {
        Name = name
        Amount = amount
        TransType = transType
        Date = date
    }
    
    public func getAdjustedAmount() -> Double {
        let adjustedAmount = TransType == TransactionType.Deposit ? Amount : Amount * -1
        return adjustedAmount
    }
    
    public func equalTo(_ rhs: Transaction) -> Bool {
        let namesAreEqual = self.Name == rhs.Name
        let amountsAreEqual = self.Amount == rhs.Amount
        let transTypeAreEqual = self.TransType == rhs.TransType
        let datesAreEqual = self.Date.extendedEqualTo(rhs.Date)
        let bothAreEqual = namesAreEqual && amountsAreEqual && transTypeAreEqual && datesAreEqual
        return bothAreEqual
    }
}

public enum TransactionType : String {
    case Deposit = "Deposit"
    case Withdrawal = "Withdrawal"
    
    static var allValues: [TransactionType] { return [Deposit, Withdrawal] }
}
