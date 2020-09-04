//
//  Transaction.swift
//  CashTrack
//
//  Created by Jake Edwards on 8/12/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import Foundation

public class Transaction {
    private(set) var Name: String
    private(set) var Amount: Double
    private(set) var Date: Date
    
    init(name: String, amount: Double, date: Date) {
        self.Name = name
        self.Amount = amount
        self.Date = date
    }
}
