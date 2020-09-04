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
    private(set) var BudgetName: String
    
    init(name: String, amount: Double, date: Date, budgetName: String) {
        self.Name = name
        self.Amount = amount
        self.Date = date
        self.BudgetName = budgetName
    }
    
    public func updateBudgetName(with newBudgetName: String) {
        self.BudgetName = newBudgetName
    }
}
