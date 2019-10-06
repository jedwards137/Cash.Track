//
//  Transaction.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import Foundation

public class Transaction {
    public var Name : String
    public var Amount : Double
    public var TransType : TransactionType
    public var Date : Date
    
    public init(name: String, amount: Double, transType: TransactionType, date: Date) {
        Name = name
        Amount = amount
        TransType = transType
        Date = date
    }
}

public enum TransactionType {
    case Deposit
    case Withdrawal
}
